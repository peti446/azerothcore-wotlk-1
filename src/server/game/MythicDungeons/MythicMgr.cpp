/*
 * Copyright (C) 2020-2020 Kito <http://www.github.com/P-Kito>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */
#include "Chat.h"
#include "Containers.h"
#include "GameEventMgr.h"
#include "Player.h"
#include "SpellInfo.h"
#include "Group.h"
#include "SpellAuraEffects.h"
#include "MythicMgr.h"
#include "Language.h"
#include "QuestDef.h"

MythicMgr::~MythicMgr() { }
MythicMgr::MythicMgr() { }

MythicMgr* MythicMgr::instance()
{
    static MythicMgr instance;
    return &instance;
}

void MythicMgr::Initialize()
{
    // Load Dungeon Best Times: Eg. Nexus - 20 Minutes = Best reward
    LoadMythicMapBestTimes();

    // Load Affix Data
    LoadMythicAffixData();

    // Load Mythic Reward Data
    LoadMythicRewardData();

    // Load Leaderboard
    LoadLeaderboards();

    // Reroll affixes if no affixes are set
    if (!sWorld->getWorldState(MYTHIC_WORLD_STATE_STAGE_0))
        RerollActiveAffixes();
    else
        ReSetActiveAffixes();
}

std::string MythicMgr::msecToTimeString(uint32 msec)
{
    uint32 secs = msec / IN_MILLISECONDS;

    std::stringstream ss;
    if (uint32 hours = secs / HOUR)
        ss << hours << " Hours ";

    ss << (secs % HOUR) / MINUTE << " Minutes " << (secs % MINUTE)
        << " Seconds and " << (msec % IN_MILLISECONDS) << " Milliseconds";

    return ss.str();
}

std::string MythicMgr::msecToMinSecTimeString(uint32 msec)
{
    uint32 secs = msec / IN_MILLISECONDS;

    std::stringstream ss;
    if (uint32 hours = secs / HOUR)
        ss << hours << ":";

    ss << (secs % HOUR) / MINUTE;

    if (uint32 seconds = secs % MINUTE)
        ss << ":" << seconds;

    return ss.str();
}

bool MythicMgr::IsIgnoredCreature(Creature* creature)
{
    if (!creature || !creature->GetGUID())
        return true;

    if (!creature->IsAlive())
        return true;

    switch (creature->GetEntry())
    {
    case NPC_MYTHIC_TOC_MOUNT_1:
    case NPC_MYTHIC_TOC_MOUNT_2:
        return false;
    case NPC_MYTHIC_VH_TRIGGER:
    case NPC_MYTHIC_FIERY_ORB:
    case NPC_MYTHIC_REPLICATING_ADD:
    case NPC_MYTHIC_REPLICATING_ADD_MINI:
    case NPC_MYTHIC_HERALD_SUMMON:
    case NPC_MYTHIC_DRAKTHARON_START:
    case NPC_MYTHIC_FOS_SOUL_FRAGMENT:
    case NPC_MYTHIC_EONARS_TRIAL:
    case NPC_MYTHIC_NEXUS_RIFT:
    case NPC_MYTHIC_RISEN_ZOMBIE:
    case NPC_MYTHIC_TOC_CHAMP_1:
    case NPC_MYTHIC_TOC_CHAMP_2:
    case NPC_MYTHIC_TOC_CHAMP_3:
    case NPC_MYTHIC_TOC_CHAMP_4:
    case NPC_MYTHIC_TOC_CHAMP_5:
    case NPC_MYTHIC_TOC_CHAMP_6:
    case NPC_MYTHIC_TOC_CHAMP_7:
    case NPC_MYTHIC_TOC_CHAMP_8:
    case NPC_MYTHIC_TOC_CHAMP_9:
    case NPC_MYTHIC_TOC_CHAMP_10:
    case NPC_MYTHIC_AN_BOSS_1_ADD:
    case NPC_MYTHIC_AN_TRASH:
    case NPC_MYTHIC_GATEWAY_ADD_1:
    case NPC_MYTHIC_GATEWAY_ADD_2:
    case NPC_MYTHIC_GATEWAY:
        return true;
    default:
        break;
    }

    // Summons by players are not affected
    if (creature->GetOwner() && creature->GetOwner()->GetTypeId() == TYPEID_PLAYER)
        return true;

    // Critters, etc
    if (creature->IsCritter() || !creature->isElite())
        return true;

    // ... nor pets or triggers
    if (creature->IsHunterPet() || creature->IsGuardian() || creature->IsTrigger())
        return true;

    return false;
}

void MythicMgr::CheckAffixCorrectness(Creature* cr, uint32 affixMask)
{
    switch (cr->GetEntry())
    {
    case 35052:
    case 35051:
    case 35050:
    case 35049:
    case 35048:
    case 35047:
    case 35046:
    case 35045:
    case 35044:
    case 35043:
    case 35042:
    case 35041:
    case 35040:
    case 35039:
    case 35038:
    case 35037:
    case 35036:
    case 35034:
    case 35033:
    case 35032:
    case 35031:
    case 35030:
    case 35029:
    case 35028:
    case 34942:
    case NPC_MYTHIC_TOC_MOUNT_1:
    case NPC_MYTHIC_TOC_MOUNT_2:
    case NPC_ICHORON_GLOBULE:
    case NPC_MYTHIC_POS_FALLEN_WAR:
    case NPC_THARON_JA:
    case NPC_MYTHIC_HADRONOX:
        return;
    default:
        break;
    }

    // No Affixes for friendly creatures
    if (!cr->IsHostileToPlayers())
        return;

    if (affixMask & MYTHIC_AFFIX_FIERY_ORB)
    {
        if (!IsBoss(cr) || IsBossAdd(cr))
            cr->RemoveAurasDueToSpell(MYTHIC_SPELL_FIERY_ORB);
        else if (!cr->HasAura(MYTHIC_SPELL_FIERY_ORB) && !IsBossAdd(cr))
            cr->CastSpell(cr, MYTHIC_SPELL_FIERY_ORB, true);
    }

    if (affixMask & MYTHIC_AFFIX_BURSTING)
    {
        if (IsBoss(cr) || IsBossAdd(cr))
            cr->RemoveAurasDueToSpell(MYTHIC_SPELL_BURSTING_AURA);
        else if (!cr->HasAura(MYTHIC_SPELL_BURSTING_AURA) && !IsBossAdd(cr))
            cr->CastSpell(cr, MYTHIC_SPELL_BURSTING_AURA, true);
    }

    if (affixMask & MYTHIC_AFFIX_RESISTING)
    {
        //if (IsBoss(cr) || IsBossAdd(cr))
        //    cr->RemoveAurasDueToSpell(MYTHIC_SPELL_RESISTING_AURA);
        //else if (!cr->HasAura(MYTHIC_SPELL_RESISTING_AURA) && !IsBossAdd(cr))
        //    cr->CastSpell(cr, MYTHIC_SPELL_RESISTING_AURA, true);

        if (!IsBoss(cr) || IsBossAdd(cr))
            cr->RemoveAurasDueToSpell(MYTHIC_SPELL_TYRANNICAL);
        else if (!cr->HasAura(MYTHIC_SPELL_TYRANNICAL))
            cr->CastSpell(cr, MYTHIC_SPELL_TYRANNICAL, true);
    }

    if (affixMask & MYTHIC_AFFIX_FRENZY)
    {
        if (IsBoss(cr) || IsBossAdd(cr))
            cr->RemoveAurasDueToSpell(MYTHIC_SPELL_FRENZY_AURA);
        else if (!cr->HasAura(MYTHIC_SPELL_FRENZY_AURA) && !IsBossAdd(cr))
            cr->CastSpell(cr, MYTHIC_SPELL_FRENZY_AURA, true);
    }

    if (affixMask & MYTHIC_AFFIX_OVERFLOW)
    {
        if (IsBoss(cr) || IsBossAdd(cr))
            cr->RemoveAurasDueToSpell(MYTHIC_SPELL_OVERFLOW_AURA_NEW);
        else if (!cr->HasAura(MYTHIC_SPELL_OVERFLOW_AURA_NEW))
            cr->CastSpell(cr, MYTHIC_SPELL_OVERFLOW_AURA_NEW, true);
    }

    if (affixMask & MYTHIC_AFFIX_LICH_KINGS_BLESSING)
    {
        if (IsBoss(cr) || IsBossAdd(cr))
            cr->RemoveAurasDueToSpell(MYTHIC_SPELL_LICH_KINGS_BLESSING_AURA);
        else if (!cr->HasAura(MYTHIC_SPELL_LICH_KINGS_BLESSING_AURA) && !IsBossAdd(cr))
            cr->CastSpell(cr, MYTHIC_SPELL_LICH_KINGS_BLESSING_AURA, true);
    }

    if (affixMask & MYTHIC_AFFIX_REPLICATION)
    {
        if (IsBoss(cr) || cr->GetOwner() || cr->IsSummon())
            cr->RemoveAurasDueToSpell(MYTHIC_SPELL_REPLICATION_AURA);
        else if (!cr->HasAura(MYTHIC_SPELL_REPLICATION_AURA) && !IsBossAdd(cr))
            cr->CastSpell(cr, MYTHIC_SPELL_REPLICATION_AURA, true);
    }
}

// Boss Adds wont receive certain affixes
bool MythicMgr::IsBossAdd(Creature* cr)
{
    if (!cr)
        return false;

    switch (cr->GetEntry())
    {
    case 24200:
    case 29573:
    case 26928:
    case 26929:
    case 26930:
        return true;
    default:
        break;
    }

    return false;
}

bool MythicMgr::IsBoss(Creature* cr)
{
    if (!cr)
        return false;

    switch (cr->GetEntry())
    {
    case 24201:
    case 23954:
    case 23953:
    case 26731:
    case 26763:
    case 26794:
    case 26723:
    case 26796:
    case 26798:
    case 28684:
    case 28921:
    case 29120:
    case 29309:
    case 29308:
    case 29310:
    case 29311:
    case 30258:
    case 26630:
    case 26631:
    case 27483:
    case 26632:
    case 29315:
    case 29316:
    case 29313:
    case 29266:
    case 29312:
    case 29314:
    case 31134:
    case 29304:
    case 29307:
    case 29305:
    case 29306:
    case 29932:
    case 27975:
    case 27977:
    case 28234:
    case 27978:
    case 26668:
    case 26687:
    case 26693:
    case 26861:
    case 35451:
    case 35119:
    case 34928:
    case 34705:
    case 34702:
    case 34701:
    case 34657:
    case 34703:
    case 35572:
    case 35569:
    case 35571:
    case 35570:
    case 35617:
    case 27654:
    case 27447:
    case 27655:
    case 27656:
    case 36497:
    case 36502:
    case 26529:
    case 26530:
    case 26532:
    case 26533:
    case 32273:
    case 36494:
    case 36476:
    case 36477:
    case 36658:
    case 38112:
    case 38113:
    case 36954:
    case 28586:
    case 28587:
    case 28546:
    case 28923:
        return true;
    default:
        return false;
    }

    return false;
}

void MythicMgr::ApplyAffix(Creature* cr, uint8 level)
{
    if (!cr || level == 0 || level >= MYTHIC_LEVEL_MAX)
        return;

    if (cr->IsDuringRemoveFromWorld() || !cr->IsInWorld())
        return;

    // Mythic Level Aura
    if (cr->GetMapId() == 632 /*MYTHIC_MAP_FOS*/ || cr->GetMapId() == 658 /*MYTHIC_MAP_POS*/ || cr->GetMapId() == 668 /*MYTHIC_MAP_HOR*/)
    {
        if (!cr->HasAura(MYTHIC_SPELL_STACK_AURA_ICC_DUNG))
            for (uint8 i = 0; i < level; i++)
                cr->CastSpell(cr, MYTHIC_SPELL_STACK_AURA_ICC_DUNG, true);
    }
    else
    {
        if (!cr->HasAura(MYTHIC_SPELL_STACK_AURA))
            for (uint8 i = 0; i < level; i++)
                cr->CastSpell(cr, MYTHIC_SPELL_STACK_AURA, true);
    }

    if (!IsBoss(cr) && !IsBossAdd(cr) && !cr->HasAura(MYTHIC_SPELL_TRASH_STACK_AURA))
    {
        for (uint8 i = 0; i < level; i++)
            cr->CastSpell(cr, MYTHIC_SPELL_TRASH_STACK_AURA, true);
    }
    else if (IsBoss(cr) || IsBossAdd(cr))
        cr->RemoveAurasDueToSpell(MYTHIC_SPELL_TRASH_STACK_AURA);

    // Affixes
    CheckAffixCorrectness(cr, GetActiveAffixesMask(level));
}

void MythicMgr::RemoveAffixes(Player* player)
{
    player->RemoveAurasDueToSpell(SPELL_MYTHIC_ABSORB_HEAL);
    player->RemoveAurasDueToSpell(MYTHIC_SPELL_OVERFLOW_AURA);
    player->RemoveAurasDueToSpell(MYTHIC_SPELL_EXPLOSIVE_AURA);
    player->RemoveAurasDueToSpell(MYTHIC_SPELL_TANK_THREAT);
    player->RemoveAurasDueToSpell(MYTHIC_SPELL_BEACON_OF_HOPE_AURA);
    player->RemoveAurasDueToSpell(MYTHIC_SPELL_EONARS_TRIAL_AURA);
    player->RemoveAurasDueToSpell(MYTHIC_SPELL_STOICISM_AURA);
}

uint32 MythicMgr::GetActiveAffixesMask(uint8 level)
{
    uint32 mask = MYTHIC_AFFIX_NONE;

    if (level >= 4)
        mask |= affixesActive[MYTHIC_STAGE_0].mask;
    if (level >= 6)
        mask |= affixesActive[MYTHIC_STAGE_1].mask;
    if (level >= 8)
        mask |= affixesActive[MYTHIC_STAGE_2].mask;
    if (level >= 10)
        mask |= affixesActive[MYTHIC_STAGE_3].mask;
    if (level >= 12)
        mask |= affixesActive[MYTHIC_STAGE_4].mask;

    return mask;
}

void MythicMgr::CheckPlayerAffixAuras(Player* player, uint8 level)
{
    if (!player || level == 0 || level >= MYTHIC_LEVEL_MAX)
        return;

    uint32 affixes = GetActiveAffixesMask(level);

    if (affixes & MYTHIC_AFFIX_EXPLOSIVE && !player->HasAura(MYTHIC_SPELL_EXPLOSIVE_AURA))
        player->CastSpell(player, MYTHIC_SPELL_EXPLOSIVE_AURA, true);

    if (affixes & MYTHIC_AFFIX_EONARS_TRIAL && player->HasHealSpec() && !player->HasAura(MYTHIC_SPELL_EONARS_TRIAL_AURA))
        player->CastSpell(player, MYTHIC_SPELL_EONARS_TRIAL_AURA, true);

    if (affixes & MYTHIC_AFFIX_BEACON_OF_HOPE && player->HasHealSpec() && !player->HasAura(MYTHIC_SPELL_BEACON_OF_HOPE_AURA))
        player->CastSpell(player, MYTHIC_SPELL_BEACON_OF_HOPE_AURA, true);

    if (affixes & MYTHIC_AFFIX_DEMONIC_STOICISM && player->HasHealSpec() && !player->HasAura(MYTHIC_SPELL_STOICISM_AURA))
        player->CastSpell(player, MYTHIC_SPELL_STOICISM_AURA, true);

    if (!player->HasAura(MYTHIC_SPELL_TANK_THREAT) && player->HasTankSpec())
        player->CastSpell(player, MYTHIC_SPELL_TANK_THREAT, true);

    if (!player->HasAura(MYTHIC_SPELL_CHILL_OF_THRONE))
        player->AddAura(MYTHIC_SPELL_CHILL_OF_THRONE, player);
}

bool MythicMgr::IsAffixSpellId(uint32 spellId)
{
    switch (spellId)
    {
        case MYTHIC_SPELL_BURSTING_AURA:
        // case MYTHIC_SPELL_TENACITY:
        case MYTHIC_SPELL_EXPLOSIVE_AURA:
        case MYTHIC_SPELL_FIERY_ORB:
        case MYTHIC_SPELL_REPLICATION_AURA:
        case MYTHIC_SPELL_STACK_AURA:
        case MYTHIC_SPELL_OVERFLOW_AURA:
        case MYTHIC_SPELL_TRASH_STACK_AURA:
        case MYTHIC_SPELL_OVERFLOW_AURA_NEW:
        case MYTHIC_SPELL_TANK_THREAT:
        case MYTHIC_SPELL_REVIVE_CHECK:
        case MYTHIC_SPELL_STACK_AURA_ICC_DUNG:
        case MYTHIC_SPELL_TYRANNICAL:
        case MYTHIC_SPELL_FRENZY_AURA:
        case MYTHIC_SPELL_RESISTING_AURA:
        case MYTHIC_SPELL_EONARS_TRIAL_AURA:
        case MYTHIC_SPELL_BEACON_OF_HOPE_AURA:
        case MYTHIC_SPELL_LICH_KINGS_BLESSING_AURA:
            return true;
        default:
            break;
    }
    return false;
}

void MythicMgr::SetAffixActive(MythicAffixStage stage, MythicAffixEntry affix)
{
    sWorld->setWorldState(MYTHIC_WORLD_STATE_STAGE_0 + stage, affix.mask);
    affixesActive.insert(MythicDungeonAffixesMap::value_type(uint32(stage), affix));
}

void MythicMgr::ReSetActiveAffixes()
{
    affixesActive.clear();

    for (auto itr : _affixesStorage)
        for (uint32 i = 0; i < MYTHIC_STAGE_MAX; i++)
            if (itr.mask == sWorld->getWorldState(MYTHIC_WORLD_STATE_STAGE_0 + i))
                affixesActive.insert(MythicDungeonAffixesMap::value_type(i, itr));
}

void MythicMgr::LoadMythicMapBestTimes()
{
    sLog->outString("Loading Mythic Map Best Times from DB.");
    _mythicBestTimeStore.clear();
    _mythicKeystoneStore.clear();

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (QueryResult result = WorldDatabase.Query("SELECT mapId, bestTime, keystone_entry FROM mythic_dungeon_times"))
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 mapId = fields[0].GetUInt32();
            uint32 bestTime = fields[1].GetUInt32();
            uint32 keyStone = fields[2].GetUInt32();

            _mythicBestTimeStore.insert(MythicBestTime::value_type(mapId, bestTime));
            if (keyStone)
                _mythicKeystoneStore.insert(MythicKeyStone::value_type(mapId, keyStone));

            ++count;
        } while (result->NextRow());
    }

    sLog->outString(">> Loaded %u Mythic Map Best Times in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

void MythicMgr::LoadMythicRewardData()
{
    _mythicItemDataStore.clear();
    sLog->outString("Loading Mythic Rewards from DB.");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (QueryResult result = WorldDatabase.Query("SELECT dungeonLevel, itemId1, itemId1Amount, itemId2, itemId2Amount, itemId3, itemId3Amount, bronzeItemId1, bronzeItemId1Amount, silverItemId1, silverItemId1Amount, goldItemId1, goldItemId1Amount FROM mythic_dungeon_rewards"))
    {
        do
        {

            Field* fields = result->Fetch();
            uint8 level = fields[0].GetUInt8();
            uint32 itemId1 = fields[1].GetUInt32();
            uint32 itemId1Count = fields[2].GetUInt32();
            uint32 itemId2 = fields[3].GetUInt32();
            uint32 itemId2Count = fields[4].GetUInt32();
            uint32 itemId3 = fields[5].GetUInt32();
            uint32 itemId3Count = fields[6].GetUInt32();
            uint32 bronzeItemId = fields[7].GetUInt32();
            uint32 bronzeItemCount = fields[8].GetUInt32();
            uint32 silverItemId = fields[9].GetUInt32();
            uint32 silverItemCount = fields[10].GetUInt32();
            uint32 goldItemId = fields[11].GetUInt32();
            uint32 goldItemCount = fields[12].GetUInt32();

            MythicItemRewards rewardItems;
            rewardItems.bronzeItemId = bronzeItemId;
            rewardItems.bronzeItemCount = bronzeItemCount;
            rewardItems.silverItemId = silverItemId;
            rewardItems.silverItemCount = silverItemCount;
            rewardItems.goldItemId = goldItemId;
            rewardItems.goldItemCount = goldItemCount;

            MythicItemRewardData nonTimedItems;
            nonTimedItems.insert(MythicItemRewardData::value_type(itemId1, itemId1Count));
            nonTimedItems.insert(MythicItemRewardData::value_type(itemId2, itemId2Count));
            nonTimedItems.insert(MythicItemRewardData::value_type(itemId3, itemId3Count));

            rewardItems.items = nonTimedItems;

            _mythicItemDataStore.insert(MythicRewardData::value_type(level, rewardItems));

            ++count;
        } while (result->NextRow());
    }

    sLog->outString(">> Loaded %u Mythic Rewards in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

void MythicMgr::LoadMythicAffixData()
{
    sLog->outString("Loading Mythic Affix Data from DB.");

    PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_MYTHIC_AFFIXES);
    uint32 oldMSTime = getMSTime();
    uint32 count = 0;
    _affixesStorage.clear();

    if (PreparedQueryResult result = WorldDatabase.Query(stmt))
    {
        do
        {
            Field* fields = result->Fetch();

            MythicAffixEntry entry;
            entry.mask = fields[0].GetUInt32();
            entry.icon = fields[1].GetString();
            entry.text = fields[2].GetString();
            entry.name = fields[3].GetString();

            _affixesStorage.push_back(entry);

            ++count;
        } while (result->NextRow());
    }

    sLog->outString(">> Loaded %u affix entries in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

void MythicMgr::RerollActiveAffixes()
{
    sLog->outString(">> Invoking Daily Mythic Affix reroll...");
    affixesActive.clear();

    MythicDungeonAffixes availableAffixes = GetAffixStore();
    if (availableAffixes.empty())
    {
        sLog->outErrorDb("ERROR: Mythic Affixes are empty! NO AFFIXES LOADED! CRASHES INCOMING!");
        return;
    }

    acore::Containers::RandomResizeList(availableAffixes, MYTHIC_STAGE_MAX);

    uint32 i = 0;
    for (MythicAffixEntry entry : availableAffixes)
    {
        SetAffixActive(MythicAffixStage(i), entry);
        i++;
    }

    sLog->outString(">> Daily Mythic Affixes rerolled... Check character.worldstates 6000-6004 for masks!");
}

void MythicMgr::LoadLeaderboards()
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MYTHIC_LEADERBOARD);
    uint32 oldMSTime = getMSTime();
    uint32 count = 0;
    _leaderboardStorage.clear();

    if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
    {
        do
        {
            Field* fields = result->Fetch();
            Tokenizer Tokenizer(fields[0].GetString(), '|');
            std::set<uint64> guids;
            uint8 index = 0;
            for (Tokenizer::const_iterator iter = Tokenizer.begin(); index < MAX_PLAYERS_MYTHIC_DUNGEON && iter != Tokenizer.end(); ++iter, ++index)
                guids.insert(uint64(atol(*iter)));

            MapLeaderboardEntry entry;
            entry.guids = guids;
            entry.level = fields[2].GetUInt8();
            entry.timeUsed = fields[3].GetUInt64();


            //std::vector<MapLeaderboardEntry>& entries = GetMythicMapLeaderboardEntries(fields[1].GetUInt32());
            //entries.push_back(entry);
            //_leaderboardStorage.insert(LeaderboardContainer::value_type(fields[1].GetUInt32(), entries));

            std::vector<MapLeaderboardEntry>& leaderboard = _leaderboardStorage[fields[1].GetUInt32()];
            leaderboard.push_back(entry);

            ++count;
        } while (result->NextRow());
    }

    sLog->outString(">> Loaded %u leaderboard entries in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

void MythicMgr::RewardFinishers(std::set<uint64> players, uint32 time, uint32 map, uint8 level)
{
    if (players.empty() || level <= 0)
        return;

    // Time lower than 50% of the gold best time? Cheating?
    /* REMOVE COMMENT ON LIVE SERVER
    if (time < GetTimeForRewardLevel(CHALLENGE_REWARD_GOLD, map) * 0.5f)
    {
        sLog->outString("MythicMgr::RewardFinishers - Possible Cheaters! No rewards were given! - Time used: %u - Group Leader Guid: %u", time, players.front()->GetGUID());
        return;
    }
    */
    std::string rewardMessage;
    MythicItemRewards rewards = GetMythicRewardItemsForLevel(level);
    uint32 timedRewards[] = { 0, 0 };

    if (time <= GetTimeForRewardLevel(CHALLENGE_REWARD_GOLD, map))
    {
        rewardMessage = "|TInterface/Icons/inv_misc_coin_17:32:32:0:-1|t Result: Cleared in time for Gold Rewards!";
        timedRewards[0] = rewards.goldItemId;
        timedRewards[1] = rewards.goldItemCount;
    }
    else if (time <= GetTimeForRewardLevel(CHALLENGE_REWARD_SILVER, map))
    {
        rewardMessage = "|TInterface/Icons/inv_misc_coin_18:32:32:0:-1|t Result: Cleared in time for Silver Rewards!";
        timedRewards[0] = rewards.silverItemId;
        timedRewards[1] = rewards.silverItemCount;
    }
    else if (time <= GetTimeForRewardLevel(CHALLENGE_REWARD_BRONZE, map))
    {
        rewardMessage = "|TInterface/Icons/inv_misc_coin_19:32:32:0:-1|t Result: Cleared in time for Bronze Rewards";
        timedRewards[0] = rewards.bronzeItemId;
        timedRewards[1] = rewards.bronzeItemCount;
    }
    else
    {
        rewardMessage = "|TInterface/Icons/spell_misc_emotionsad:32:32:0:-1|t Result: Not cleared in time! (Basic Rewards)";
    }

    for (uint64 initialPlayerGuid : players)
    {
        Player* initialPlayer = ObjectAccessor::FindPlayer(initialPlayerGuid);
        if (!initialPlayer)
            continue;

        // Remove all Affixes
        RemoveAffixes(initialPlayer);

        // Reward all initial players who are still on the same map
        if (initialPlayer->GetMapId() == map)
        {
            ChatHandler handler(initialPlayer->GetSession());
            handler.SendSysMessage(rewardMessage.c_str());
            handler.SendSysMessage("------------------ Distributing Rewards -------------------");

            for (auto item : rewards.items)
                if (item.first && item.second)
                    initialPlayer->AddItem(item.first, item.second);

            if (timedRewards[0] && timedRewards[1])
                initialPlayer->AddItem(timedRewards[0], timedRewards[1]);

            handler.SendSysMessage("-----------------------------------------------------------");

            // Give new Keystone
            GiveRandomKeystone(initialPlayer);

            if (Quest const* qGold = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_GOLD, map))
                if (Quest const* qSilver = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_SILVER, map))
                    if (Quest const* qBronze = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_BRONZE, map))
                    {
                        initialPlayer->RemoveRewardedQuest(qBronze->GetQuestId());
                        initialPlayer->RemoveRewardedQuest(qSilver->GetQuestId());
                        initialPlayer->RemoveRewardedQuest(qGold->GetQuestId());
                        initialPlayer->RemoveActiveQuest(qBronze->GetQuestId(), false);
                        initialPlayer->RemoveActiveQuest(qSilver->GetQuestId(), false);
                        initialPlayer->RemoveActiveQuest(qGold->GetQuestId(), false);

                        for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
                        {
                            uint32 logQuest = initialPlayer->GetQuestSlotQuestId(slot);
                            if (logQuest == qGold->GetQuestId() || logQuest == qSilver->GetQuestId() || logQuest == qBronze->GetQuestId())
                                initialPlayer->SetQuestSlot(slot, 0);
                        }
                    }
        }
    }

    // Add to Leaderboard
    AddToLeaderboard(players, time, map, level);
}

void MythicMgr::AddToLeaderboard(std::set<uint64> guids, uint32 timeUsed, uint32 map, uint8 level)
{
    // Get Entries for that map
    std::vector<MapLeaderboardEntry>& leaderboard = _leaderboardStorage[map];

    // Iterate and find entry which has same level and same player group
    // and update their time for that level
    for (MapLeaderboardEntry mapEntry : leaderboard)
        if (mapEntry.guids == guids && mapEntry.level == level)
        {
            if (timeUsed < mapEntry.timeUsed)
                mapEntry.timeUsed = timeUsed;
            break;
        }

    // That group never ran that level, creating a new entry
    MapLeaderboardEntry entry;
    entry.guids = guids;
    entry.level = level;
    entry.timeUsed = timeUsed;

    leaderboard.push_back(entry);

    std::ostringstream guidString;
    for (uint64 const playerGuid : guids)
        guidString << GUID_LOPART(playerGuid) << '|';

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_MYTHIC_GROUP);
    stmt->setString(0, guidString.str());
    stmt->setUInt32(1, map);
    stmt->setUInt8(2, level);
    stmt->setUInt64(3, timeUsed);
    stmt->setUInt32(4, GetActiveAffixesMask(level));
    CharacterDatabase.Execute(stmt);

    std::string announceText = "[MYTHIC INFO][PLAYERS";
    for (uint64 playerGuid : guids)
    {
        std::string name;
        sObjectMgr->GetPlayerNameByGUID(playerGuid, name);
        announceText += " - " + name;
    }
    announceText += "] "+GetDungeonNameByMap(map)+" (+"+std::to_string(level)+") cleared in " + msecToMinSecTimeString(timeUsed) + " Minutes!";
    sWorld->SendWorldText(LANG_REALM_ANNOUNCE_MYTHIC_TIME, announceText.c_str());
}

uint32 MythicMgr::GetTimeForRewardLevel(ChallengeRewardLevel level, uint32 map)
{
    uint32 bestTime = GetMythicBestTimeForMap(map);
    return bestTime * GetRewardTimeMod(level);
}

MythicItemRewards MythicMgr::GetMythicRewardItemsForLevel(uint8 level)
{
    MythicItemRewards rewards;
    auto itr = _mythicItemDataStore.find(level);
    if (itr == _mythicItemDataStore.end())
        return rewards;
    return itr->second;
}

uint32 MythicMgr::GetMythicBestTimeForMap(uint32 mapId)
{
    auto itr = _mythicBestTimeStore.find(mapId);
    if (itr == _mythicBestTimeStore.end())
        return 0;
    return itr->second;
}

uint32 MythicMgr::GetMythicKeystoneForMap(uint32 mapId)
{
    auto itr = _mythicKeystoneStore.find(mapId);
    if (itr == _mythicKeystoneStore.end())
        return 0;
    return itr->second;
}

bool MythicMgr::HasKeyStoneForDungeon(Player* player, uint32 mapId)
{
    uint32 keyStoneEntry = GetMythicKeystoneForMap(mapId);
    return player->HasItemCount(keyStoneEntry);
}

void MythicMgr::GiveRandomKeystone(Player* player, bool command, bool reroll)
{
    if (!player)
        return;

    MythicKeyStone const& keystones = GetMythicKeystoneStore();
    if (keystones.empty())
        return;

    bool hasStone = false;
    if (!command)
    {
        for (auto keystone : keystones)
        {
            if (player->HasItemCount(keystone.second, 1, true))
                hasStone = true;
            if (keystone.first == player->GetMapId() || reroll)
                if (player->HasItemCount(keystone.second, 1, true))
                {
                    player->DestroyItemCount(keystone.second, -1, true, false);
                    hasStone = false;
                }
        }
    }

    auto stone = acore::Containers::SelectRandomContainerElement(keystones);
    uint32 entry = stone.second;
    if (entry && !hasStone)
    {
        ChatHandler handler(player->GetSession());
        handler.SendSysMessage("--- NEW KEYSTONE AQUIRED!");
        player->AddItem(entry, 1);
    }
}

std::vector<MapLeaderboardEntry>& MythicMgr::GetMythicMapLeaderboardEntries(uint32 map)
{
    static std::vector<MapLeaderboardEntry> mapEntries;
    mapEntries.clear();
    auto itr = _leaderboardStorage.find(map);
    if (itr == _leaderboardStorage.end())
        return mapEntries;
    return itr->second;
}

uint64 MythicMgr::GetPlayerBestTimeForMapAndLevel(uint64 guid, uint32 map, uint8 level, bool returnBest)
{
    std::vector<MapLeaderboardEntry> entries = GetMythicMapLeaderboardEntries(map);

    uint64 bestTime = 0;
    for (MapLeaderboardEntry entry : entries)
        if (entry.level == level)
            for (uint64 entryGuid : entry.guids)
                if (entryGuid == guid || returnBest)
                {
                    if (entry.timeUsed < bestTime || bestTime == 0)
                        bestTime = entry.timeUsed;
                    break;
                }

    return bestTime;
}

std::set<uint64> MythicMgr::GetGUIDsForMapAndLevel(uint64 guid, uint32 map, uint8 level, bool returnBest)
{
    std::vector<MapLeaderboardEntry> entries = GetMythicMapLeaderboardEntries(map);

    uint64 bestTime = 0;
    std::set<uint64> bestGuids;
    for (MapLeaderboardEntry entry : entries)
        if (entry.level == level)
            for (uint64 entryGuid : entry.guids)
                if (entryGuid == guid || returnBest)
                {
                    if (entry.timeUsed < bestTime || bestTime == 0)
                    {
                        bestTime = entry.timeUsed;
                        bestGuids = entry.guids;
                    }
                    break;
                }

    return bestGuids;
}

uint8 MythicMgr::GetHighestLevelForGUID(uint64 guid)
{
    uint8 level = 0;
    for (auto itr : _leaderboardStorage)
    {
        std::vector<MapLeaderboardEntry> entries = itr.second;
        for (auto entry : entries)
            if (entry.guids.find(guid) != entry.guids.end())
                if (level < entry.level)
                    level = entry.level;
    }
    return level;
}

std::string MythicMgr::GetClassIcon(uint8 playerClass)
{
    static std::string const classIcons[MAX_CLASSES] =
    {
        "|TInterface\\icons\\inv_misc_questionmark:32:32:-30:-1|t",       // 0 - None
        "|TInterface\\icons\\inv_sword_27:32:32:-30:-1|t",                // 1 - Warrior
        "|TInterface\\icons\\ability_thunderbolt:32:32:-30:-1|t",         // 2 - Paladin
        "|TInterface\\icons\\inv_weapon_bow_07:32:32:-30:-1|t",           // 3 - Hunter
        "|TInterface\\icons\\inv_throwingknife_04:32:32:-30:-1|t",        // 4 - Rogue
        "|TInterface\\icons\\inv_staff_30:32:32:-30:-1|t",                // 5 - Priest
        "|TInterface\\icons\\spell_deathknight_classicon:32:32:-30:-1|t", // 6 - Death Knight
        "|TInterface\\icons\\inv_jewelry_talisman_04:32:32:-30:-1|t",     // 7 - Shaman
        "|TInterface\\icons\\inv_staff_13:32:32:-30:-1|t",                // 8 - Mage
        "|TInterface\\icons\\spell_nature_drowsy:32:32:-30:-1|t",         // 9 - Warlock
        "",                                                               // 10 - Unk
        "|TInterface\\icons\\inv_misc_monsterclaw_04:32:32:-30:-1|t",     // 11 - Druid
    };

    if (playerClass >= MAX_CLASSES)
        return classIcons[CLASS_NONE];

    return classIcons[playerClass];
}

bool MythicMgr::GetPlayerNameClassByGUID(uint64 guid, std::string& name, uint8& classId) const
{
    // prevent DB access for online player
    if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
    {
        name = player->GetName();
        classId = player->getClass();
        return true;
    }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_NAME_CLASS);

    stmt->setUInt32(0, GUID_LOPART(guid));

    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (result)
    {
        name = (*result)[0].GetString();
        classId = (*result)[1].GetUInt8();

        return true;
    }

    return false;
}

Quest const* MythicMgr::GetQuestForRewardLevel(ChallengeRewardLevel level, uint32 mapId)
{
    static std::map<uint32 /*map*/, uint32 /*quest*/> questsDungeonMap =
    {
        { 576, MYTHIC_QUEST_START + 0  }, // Nexus
        { 608, MYTHIC_QUEST_START + 3  }, // Violet Hold
        { 604, MYTHIC_QUEST_START + 6  }, // Gundrak
        { 668, MYTHIC_QUEST_START + 9  }, // HoR
        { 658, MYTHIC_QUEST_START + 12 }, // Pit of Saron
        { 650, MYTHIC_QUEST_START + 15 }, // ToC
        { 632, MYTHIC_QUEST_START + 18 }, // Forge of Souls
        { 602, MYTHIC_QUEST_START + 21 }, // HoL
        { 601, MYTHIC_QUEST_START + 24 }, // Azjol Nerub
        { 600, MYTHIC_QUEST_START + 27 }, // Draktharon Keep
        { 599, MYTHIC_QUEST_START + 30 }, // HoS
        { 595, MYTHIC_QUEST_START + 33 }, // Straholme
        { 575, MYTHIC_QUEST_START + 36 }, // Utgard Pinnacle
        { 574, MYTHIC_QUEST_START + 39 }, // Utgard Keep
        { 619, MYTHIC_QUEST_START + 42 }  // AhnKahet
    };

    switch (level)
    {
        case CHALLENGE_REWARD_BRONZE:
            if (Quest const* q = sObjectMgr->GetQuestTemplate(questsDungeonMap.at(mapId) + 2))
                return q;
        case CHALLENGE_REWARD_SILVER:
            if (Quest const* q = sObjectMgr->GetQuestTemplate(questsDungeonMap.at(mapId) + 1))
                return q;
        case CHALLENGE_REWARD_GOLD:
            if (Quest const* q = sObjectMgr->GetQuestTemplate(questsDungeonMap.at(mapId)))
                return q;
        default:
            break;
    }

    return (Quest*)NULL;
}

uint32 MythicMgr::GetQuestTimeForLevel(ChallengeRewardLevel level, uint32 questTimeAllowed)
{
    return questTimeAllowed * GetRewardTimeMod(level);
}

// WHEN CHANGING THESE NUMBERS, THEY ALSO NEED TO BE CHANGED IN SQL
float MythicMgr::GetRewardTimeMod(ChallengeRewardLevel level)
{
    switch (level)
    {
        case CHALLENGE_REWARD_BRONZE:
            return 1.60f;
        case CHALLENGE_REWARD_SILVER:
            return 1.30f;
        case CHALLENGE_REWARD_GOLD:
            return 1.0f;
        default:
            break;
    }
    return 1.0f;
}

std::string MythicMgr::GetDungeonNameByMap(uint32 map)
{
    std::string name = "Unknown";

    switch (map)
    {
    case 576:
        name = "The Nexus";
        break;
    case 574:
        name = "Utgard Keep";
        break;
    case 575:
        name = "Utgard Pinnacle";
        break;
    case 595:
        name = "Culling of Stratholme";
        break;
    case 599:
        name = "Halls of Stone";
        break;
    case 600:
        name = "Drak Tharon";
        break;
    case 601:
        name = "Azjol Nerub";
        break;
    case 602:
        name = "Halls of Lightning";
        break;
    case 619:
        name = "Ahn Kahet";
        break;
    case 632:
        name = "Forge of Souls";
        break;
    case 650:
        name = "Trial of Champions";
        break;
    case 658:
        name = "Pit of Saron";
        break;
    case 668:
        name = "Halls of Reflection";
        break;
    case 604:
        name = "Gundrak";
        break;
    case 608:
        name = "Violet Hold";
        break;
    default:
        break;
    }

    return name;
}

