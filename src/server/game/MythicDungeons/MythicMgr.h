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

#pragma once

enum MythicWorldState
{
    MYTHIC_WORLD_STATE_STAGE_0 = 6000,
    MYTHIC_WORLD_STATE_STAGE_1 = 6001,
    MYTHIC_WORLD_STATE_STAGE_2 = 6002,
    MYTHIC_WORLD_STATE_STAGE_3 = 6003,
    MYTHIC_WORLD_STATE_STAGE_4 = 6004,
};

enum MythicAffix : uint32
{
    MYTHIC_AFFIX_NONE                   = 0,
    MYTHIC_AFFIX_BURSTING               = 1,    // Done: Each Non-Boss enemy killed causes all players to take 16% of their max health for 3 seconds.
    MYTHIC_AFFIX_EXPLOSIVE              = 2,    // Done: Periodically, the ground underneath a player trembles, dealing 24000 damage in a small area after 4 seconds.
    MYTHIC_AFFIX_FIERY_ORB              = 4,    // Done: Bosses spawn a fiery orb every 18 seconds, which periodically damage all players unless killed.
    MYTHIC_AFFIX_REPLICATION            = 8,    // Done: Non-Boss enemies have a chance to spawn a Replicating Arcane Aberration which knockbacks all players when killed.
    MYTHIC_AFFIX_OVERFLOW               = 16,   // Done: Periodically Non-Boss enemies damage nearby players.
    MYTHIC_AFFIX_RESISTING              = 32,   // Done: Boss enemies have 30% increased health.
    MYTHIC_AFFIX_FRENZY                 = 64,   // Done: Once below 30% health, non-boss enemies get in frenzy which increases nearby enemies attackspeed by 33%.
    MYTHIC_AFFIX_LICH_KINGS_BLESSING    = 128,  // Done: Non-boss enemies periodically become infused with the Lich Kings Blessing. Infused enemies have 75% reduced movement speed, but deal 150% more physical damage, 50% more magic damage and have 100% more attack speed.
    MYTHIC_AFFIX_EONARS_TRIAL           = 256,  // Done: Periodically, Eonar tests your group. If you fail to heal her Tree of Life within 7 seconds, all players get feared.
    MYTHIC_AFFIX_BEACON_OF_HOPE         = 512,  // Done: Periodically, a random player will be assigned your party’s Beacon of Hope. Any player not in range of the Beacon of Hope after 6 seconds will fall into despair causing them to become disoriented.
    MYTHIC_AFFIX_DEMONIC_STOICISM       = 1024, // Done: Periodically, a demonic gateway will open up and a random demon will assault your group.

    MYTHIC_AFFIX_MAX
};

enum MythicAffixStage
{
    MYTHIC_STAGE_0 = 0, // 1 "
    MYTHIC_STAGE_1 = 1, // 2 "
    MYTHIC_STAGE_2 = 2, // 3 "
    MYTHIC_STAGE_3 = 3, // 4 "
    MYTHIC_STAGE_4 = 4, // 5 "

    MYTHIC_STAGE_MAX
};

enum MythicMisc
{
    MYTHIC_MAX_REWARD = 3,
    MYTHIC_START_DOOR = 500000,
    MYTHIC_TIME_CHEAT_THRESHOLD = 480000, // 8 Minutes

    MAX_PLAYERS_MYTHIC_DUNGEON = 5,
    MYTHIC_UNLOCK_RANGE = 4,  // A Level 5 run allows up to Level 9 runs now, players have to start with Level <= 4

    MYTHIC_QUEST_START = 300000,

    MYTHIC_MAP_FOS = 632,
    MYTHIC_MAP_POS = 658,
    MYTHIC_MAP_HOR = 668,

    LANG_REALM_ANNOUNCE_MYTHIC_TIME = 11187
};

enum MythicNPCs
{
    NPC_MYTHIC_CONTROLLER = 200000,
    NPC_MYTHIC_EXPLOSION_TRIGGER = 200001,
    NPC_MYTHIC_FIERY_ORB = 200002,
    NPC_MYTHIC_REPLICATING_ADD = 200003,
    NPC_MYTHIC_REPLICATING_ADD_MINI = 200004,
    NPC_ICHORON_GLOBULE = 29321,
    NPC_THARON_JA = 26632,
    NPC_MYTHIC_HERALD_SUMMON = 30625,
    NPC_MYTHIC_DRAKTHARON_START = 26620,
    NPC_MYTHIC_HADRONOX = 28921,
    NPC_MYTHIC_VH_TRIGGER = 31011,
    NPC_MYTHIC_DRAKTHARON_BATRIDER = 26638,
    NPC_MYTHIC_FOS_SOUL_FRAGMENT = 36535,
    NPC_MYTHIC_EONARS_TRIAL = 200005,
    NPC_MYTHIC_NEXUS_RIFT = 26918,
    NPC_MYTHIC_TOC_MOUNT_1 = 35644,
    NPC_MYTHIC_TOC_MOUNT_2 = 36558,
    NPC_MYTHIC_POS_FALLEN_WAR = 36841,
    NPC_MYTHIC_RISEN_ZOMBIE = 27737,
    NPC_MYTHIC_TOC_CHAMP_1 = 35617,
    NPC_MYTHIC_TOC_CHAMP_2 = 35572,
    NPC_MYTHIC_TOC_CHAMP_3 = 35571,
    NPC_MYTHIC_TOC_CHAMP_4 = 35570,
    NPC_MYTHIC_TOC_CHAMP_5 = 35569,
    NPC_MYTHIC_TOC_CHAMP_6 = 34705,
    NPC_MYTHIC_TOC_CHAMP_7 = 34703,
    NPC_MYTHIC_TOC_CHAMP_8 = 34702,
    NPC_MYTHIC_TOC_CHAMP_9 = 34701,
    NPC_MYTHIC_TOC_CHAMP_10 = 34657,
    NPC_MYTHIC_KRYSTALLUS = 27977,
    NPC_MYTHIC_AN_BOSS_1_ADD = 28735,
    NPC_MYTHIC_AN_TRASH = 32593,
    NPC_MYTHIC_GATEWAY = 200008,
    NPC_MYTHIC_GATEWAY_ADD_1 = 200007,
    NPC_MYTHIC_GATEWAY_ADD_2 = 200009
};

enum MythicSpellId
{
    MYTHIC_SPELL_TENACITY = 58549,
    MYTHIC_SPELL_BURSTING_AURA = 100200,
    MYTHIC_SPELL_EXPLOSIVE_AURA = 100201,
    MYTHIC_SPELL_FIERY_ORB = 100202,
    MYTHIC_SPELL_REPLICATION_AURA = 100203,
    MYTHIC_SPELL_BURSTING_DOT = 22682,
    MYTHIC_SPELL_STACK_AURA = 100204,
    MYTHIC_SPELL_OVERFLOW_AURA = 100205,
    SPELL_MYTHIC_ABSORB_HEAL = 72491,
    MYTHIC_SPELL_TRASH_STACK_AURA = 100206,
    MYTHIC_SPELL_OVERFLOW_AURA_NEW = 100207,
    MYTHIC_SPELL_UNENDING_PAIN = 57381,
    MYTHIC_SPELL_TANK_THREAT = 100208,
    MYTHIC_SPELL_REVIVE_CHECK = 100209,
    MYTHIC_SPELL_REVIVE_SPRINT = 56354,
    MYTHIC_SPELL_CHILL_OF_THRONE = 69127,
    MYTHIC_SPELL_STACK_AURA_ICC_DUNG = 100210,
    MYTHIC_SPELL_RESISTING = 72723,
    MYTHIC_SPELL_FRENZY = 3136,
    MYTHIC_SPELL_TYRANNICAL = 100212,
    MYTHIC_SPELL_FRENZY_AURA = 100213,
    MYTHIC_SPELL_RESISTING_AURA = 100214,
    MYTHIC_SPELL_EONARS_TRIAL_AURA = 100215,
    MYTHIC_SPELL_BEACON_OF_HOPE_AURA = 100216,
    MYTHIC_SPELL_BEACON_OF_HOPE_TARGET_SELECT = 100217,
    MYTHIC_SPELL_HOLY_ZONE = 70571,
    MYTHIC_SPELL_MIST_KVALDIR = 50203, // white
    MYTHIC_SPELL_ZOMBIE_VISION = 50224, // red
    MYTHIC_SPELL_HOLY_SHORT_AURA = 46591,
    MYTHIC_SPELL_CONFUSE_BEACON = 22289,
    MYTHIC_SPELL_BEACON_GROW = 39946,
    MYTHIC_SPELL_HOLY_BOMB = 70786,
    MYTHIC_SPELL_SENTINEL_BLAST = 64389,
    MYTHIC_SPELL_LICH_KINGS_BLESSING_AURA = 100218,
    MYTHIC_SPELL_UNHOLY_POWER = 69167,
    MYTHIC_SPELL_PETRYFYING_GRIP = 50836,
    MYTHIC_SPELL_CAST_SPEED_REDUCTION = 100219,
    MYTHIC_SPELL_UNHOLY_POWER_ATSP = 40743,
    MYTHIC_SPELL_UNHOLY_POWER_VSL = 17327,
    MYTHIC_SPELL_GIFT_OF_THARON_JA = 52509,
    MYTHIC_SPELL_STOICISM_AURA = 100220,
    MYTHIC_SPELL_INSANITY_PHASING_1 = 57508,
    MYTHIC_SPELL_INSANITY_PHASING_2 = 57509,
    MYTHIC_SPELL_INSANITY_PHASING_3 = 57510,
    MYTHIC_SPELL_INSANITY_PHASING_4 = 57511,
    MYTHIC_SPELL_INSANITY_PHASING_5 = 57512
};

// Time based rewards
enum ChallengeRewardLevel : uint8
{
    CHALLENGE_REWARD_GOLD   = 1,
    CHALLENGE_REWARD_SILVER = 2,
    CHALLENGE_REWARD_BRONZE = 3
};

enum MythicLevel
{
    MYTHIC_LEVEL_1  = 1,
    MYTHIC_LEVEL_2  = 2,
    MYTHIC_LEVEL_3  = 3,
    MYTHIC_LEVEL_4  = 4,
    MYTHIC_LEVEL_5  = 5,
    MYTHIC_LEVEL_6  = 6,
    MYTHIC_LEVEL_7  = 7,
    MYTHIC_LEVEL_8  = 8,
    MYTHIC_LEVEL_9  = 9,
    MYTHIC_LEVEL_10 = 10,
    MYTHIC_LEVEL_11 = 11,
    MYTHIC_LEVEL_12 = 12,
    MYTHIC_LEVEL_13 = 13,
    MYTHIC_LEVEL_14 = 14,
    MYTHIC_LEVEL_15 = 15,

    MYTHIC_LEVEL_MAX
};

typedef std::unordered_map<uint32 /*mapId*/, uint32 /*gold time*/> MythicBestTime;

typedef std::unordered_map<uint32 /*mapId*/, uint32 /*keystone Entry*/> MythicKeyStone;

typedef std::unordered_map<uint32 /*item entry*/, uint32 /*amount*/> MythicItemRewardData;

struct MapLeaderboardEntry
{
    uint8 level;
    std::set<uint64> guids;
    uint64 timeUsed;
};

typedef std::unordered_map<uint32 /*mapid*/, std::vector<MapLeaderboardEntry>> LeaderboardContainer;

struct MythicItemRewards
{
    MythicItemRewardData items;
    uint32 goldItemId;
    uint32 goldItemCount;
    uint32 silverItemId;
    uint32 silverItemCount;
    uint32 bronzeItemId;
    uint32 bronzeItemCount;
};

typedef std::unordered_map<uint8 /*level*/, MythicItemRewards /*items*/> MythicRewardData;

struct MythicAffixEntry
{
    uint32 mask;
    std::string name;
    std::string icon;
    std::string text;
};

typedef std::map<uint32 /*level*/, MythicAffixEntry> MythicDungeonAffixesMap;
typedef std::list<MythicAffixEntry> MythicDungeonAffixes;

class MythicMgr
{
    public:
        MythicMgr();
        ~MythicMgr();

        static MythicMgr* instance();

        void Initialize();

        std::string msecToTimeString(uint32 msec);
        std::string msecToMinSecTimeString(uint32 msec);
        std::string GetClassIcon(uint8 playerClass);
        bool GetPlayerNameClassByGUID(uint64 guid, std::string& name, uint8& classId) const;
        std::string GetDungeonNameByMap(uint32 map);
        bool IsBoss(Creature* cr);
        bool IsBossAdd(Creature* cr);

        /*
         * Affixes
         */
        void LoadMythicAffixData();
        void SetAffixActive(MythicAffixStage stage, MythicAffixEntry affix);
        uint32 GetActiveAffixesMask(uint8 level);
        void ApplyAffix(Creature* cr, uint8 level);
        bool IsAffixSpellId(uint32 spellId);
        void CheckPlayerAffixAuras(Player* player, uint8 level);
        void RemoveAffixes(Player* player);
        void RerollActiveAffixes();
        MythicDungeonAffixes GetAffixStore() { return _affixesStorage; }
        MythicDungeonAffixesMap GetActiveAffixes() { return affixesActive; }
        void ReSetActiveAffixes();
        bool IsIgnoredCreature(Creature* cr);
        void CheckAffixCorrectness(Creature* cr, uint32 affixMask);

        /*
         * Dungeon Best Times
         */
        void LoadMythicMapBestTimes();
        MythicBestTime const& GetMythicBestTimeStore() const { return _mythicBestTimeStore; }
        uint32 GetMythicBestTimeForMap(uint32 mapId);
        void AddToLeaderboard(std::set<uint64> guids, uint32 timeUsed, uint32 map, uint8 level);
        void LoadLeaderboards();
        uint64 GetPlayerBestTimeForMapAndLevel(uint64 guid, uint32 map, uint8 level, bool returnBest = false);
        std::vector<MapLeaderboardEntry>& GetMythicMapLeaderboardEntries(uint32 map);
        std::set<uint64> GetGUIDsForMapAndLevel(uint64 guid, uint32 map, uint8 level, bool returnBest = false);
        uint8 GetHighestLevelForGUID(uint64 guid);
        Quest const* GetQuestForRewardLevel(ChallengeRewardLevel level, uint32 mapId);
        uint32 GetQuestTimeForLevel(ChallengeRewardLevel level, uint32 questTimeAllowed);
        float GetRewardTimeMod(ChallengeRewardLevel level);

        /*
         * Keystones
         */
        MythicKeyStone const& GetMythicKeystoneStore() const { return _mythicKeystoneStore; }
        uint32 GetMythicKeystoneForMap(uint32 mapId);
        bool HasKeyStoneForDungeon(Player* player, uint32 mapId);
        void GiveRandomKeystone(Player* player, bool command = false, bool reroll = false);

        /*
         * Rewarding
         */
        void RewardFinishers(std::set<uint64> players, uint32 time, uint32 map, uint8 level);
        uint32 GetTimeForRewardLevel(ChallengeRewardLevel level, uint32 map);
        MythicRewardData const& GetMythicItemDataStore() const { return _mythicItemDataStore; }
        MythicItemRewards GetMythicRewardItemsForLevel(uint8 level);
        void LoadMythicRewardData();

    private:
        /*
         * Affixes
         */
        MythicDungeonAffixesMap affixesActive;
        MythicDungeonAffixes _affixesStorage;

        /*
         * Dungeon Best Times
         */
        MythicBestTime _mythicBestTimeStore;
        LeaderboardContainer _leaderboardStorage;

        MythicKeyStone _mythicKeystoneStore;

        /*
         * Rewarding
         */
        MythicRewardData _mythicItemDataStore;
};

#define sMythicMgr MythicMgr::instance()
