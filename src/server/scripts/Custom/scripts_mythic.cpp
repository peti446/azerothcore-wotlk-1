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
#include "ScriptMgr.h"
#include "Group.h"
#include "Chat.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "MythicMgr.h"
#include "Player.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "Spell.h"
#include "SpellScript.h"
#include "SpellMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"

enum Spells
{
    SPELL_VISUAL_FINISH = 41300
};

enum Events
{
    EVENT_UPDATE_TIMER = 1,
    EVENT_ANTI_CHEAT = 2,
    EVENT_CHECK_AFFIXES = 3
};

enum GossipMisc
{
    GOSSIP_OPTION_NO_ACTION = 900,
    GOSSIP_SHOW_AFFIX_INFO = 901,
    GOSSIP_SHOW_MAIN_MENU = 902,
    GOSSIP_SHOW_MY_TIMES = 903,
    GOSSIP_SHOW_TIME_DETAIL = 904,
    // +15 levels
    GOSSIP_SHOW_TIME_DETAIL_BEST = 925,
    // +15 levels
    GOSSIP_PLACEHOLDER = 936,
    GOSSIP_ACTION_REROLL = 940,
    GOSSIP_ACTION_SHOW_REWARD_LEVELS = 941,
    GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL = 942,
    // + 15 levels
};

enum GossipNPCText
{
    GOSSIP_NPC_TEXT = 600000,
    GOSSIP_NPC_TEXT_BEST_TIMES = 600001
};

class npc_mythic_plus_info : public CreatureScript
{
public:
    npc_mythic_plus_info() : CreatureScript("npc_mythic_plus_info") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        player->PlayerTalkClass->ClearMenus();
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "------------ Todays Affixes:", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
        uint32 levelCounter = 4;
        for (auto itr : sMythicMgr->GetActiveAffixes())
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, itr.second.icon + " " + itr.second.name + " - Level " + std::to_string(levelCounter) + "+", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_AFFIX_INFO);
            levelCounter += 2;
        }
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
        player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_key_15:32:32:-30:-1|t Reroll my Mythic Key...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_REROLL, "This costs 5 Mythic Coins and gives you a RANDOM new key!", 0, false);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_book_03:32:32:-30:-1|t Show Rewards in detail...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SHOW_REWARD_LEVELS);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_book_03:32:32:-30:-1|t Show Affixes Description...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_AFFIX_INFO);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
        uint8 highestLevel = sMythicMgr->GetHighestLevelForGUID(player->GetGUID());
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_key_02:32:32:-30:-1|t Your highest Level: " + std::to_string(highestLevel), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_key_02:32:32:-30:-1|t Unlocks Levels up to " + std::to_string(std::min(highestLevel + MYTHIC_UNLOCK_RANGE, MYTHIC_LEVEL_MAX - 1)), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);

        player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        player->PlayerTalkClass->ClearMenus();

        ChatHandler Handler(player->GetSession());

        if (action == GOSSIP_OPTION_NO_ACTION)
        {
            player->PlayerTalkClass->SendCloseGossip();
            return true;
        }

        if (action == GOSSIP_SHOW_MAIN_MENU)
        {
            OnGossipHello(player, creature);
            return true;
        }

        if (action == GOSSIP_ACTION_SHOW_REWARD_LEVELS)
        {
            for (uint8 i = 1; i < uint8(MYTHIC_LEVEL_MAX); i++)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_01:32:32:-30:-1|t Rewards for Level " + std::to_string(i), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL + i);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MAIN_MENU);
            player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
            return true;
        }

        if (action > GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL && action <= GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL + 15)
        {
            uint8 level = action - GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL;
            MythicItemRewards rewards = sMythicMgr->GetMythicRewardItemsForLevel(level);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "------------ Rewards for Level " + std::to_string(level), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            for (auto staticReward : rewards.items)
            {
                uint32 itemEntry = staticReward.first;
                uint32 amount = staticReward.second;
                ItemTemplate const* item = sObjectMgr->GetItemTemplate(itemEntry);
                if (item)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_01:32:32:-30:-1|t " + std::to_string(amount) + "x " + item->Name1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            }
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "------------ Bonus for finishing in time", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            ItemTemplate const* item = sObjectMgr->GetItemTemplate(rewards.goldItemId);
            if (item)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_17:32:32:-30:-1|t " + std::to_string(rewards.goldItemCount) + "x " + item->Name1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            item = sObjectMgr->GetItemTemplate(rewards.silverItemId);
            if (item)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_18:32:32:-30:-1|t " + std::to_string(rewards.silverItemCount) + "x " + item->Name1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            item = sObjectMgr->GetItemTemplate(rewards.bronzeItemId);
            if (item)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_19:32:32:-30:-1|t " + std::to_string(rewards.bronzeItemCount) + "x " + item->Name1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);

            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SHOW_REWARD_LEVELS);
            player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
            return true;
        }

        if (action == GOSSIP_ACTION_REROLL)
        {
            if (player->HasItemCount(3929, 5, true))
            {
                player->DestroyItemCount(3929, 5, true);
                sMythicMgr->GiveRandomKeystone(player, false, true);
                Handler.PSendSysMessage("Removed 5 Mythic Coins for a new mythic keystone!");
            }
            else
                Handler.PSendSysMessage("You dont have enough Mythic Coins! (You need 5 Coins)");

            player->PlayerTalkClass->SendCloseGossip();
            return true;
        }
        if (action == GOSSIP_SHOW_AFFIX_INFO)
        {
            for (MythicAffixEntry affixEntry : sMythicMgr->GetAffixStore())
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, affixEntry.icon + " " + affixEntry.name, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, affixEntry.text, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            }
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MAIN_MENU);
            player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
            return true;
        }

        return false;
    }
};

class npc_mythic_plus_controller : public CreatureScript
{
    public:
        npc_mythic_plus_controller() : CreatureScript("npc_mythic_plus_controller") { }

        struct npc_mythic_plus_controllerAI : ScriptedAI
        {
            npc_mythic_plus_controllerAI(Creature* creature) : ScriptedAI(creature)
            {
                _instance = me->GetInstanceScript();
                timeStart = 0;
                initialPlayers.clear();
            }

            void Reset() override
            {
                _events.Reset();
            }

            void DoAction(int32 action) override
            {
                if (action == 100)
                {
                    uint32 time = GetMSTimeDiffToNow(timeStart);
                    std::string message = "|TInterface/Icons/spell_holy_borrowedtime:32:32:0:-1|t Your time: " + sMythicMgr->msecToTimeString(time);


                    for (uint64 initialPlayerGuid : initialPlayers)
                    {
                        Player* initialPlayer = ObjectAccessor::FindPlayer(initialPlayerGuid);
                        if (!initialPlayer)
                            continue;
                        // Reward all initial players who are still on the same map
                        if (initialPlayer->GetMapId() == me->GetMapId())
                        {
                            ChatHandler handler(initialPlayer->GetSession());
                            handler.SendSysMessage("----------------- Mythic Dungeon Cleared -----------------");
                            handler.SendSysMessage(message.c_str());
                            handler.SendSysMessage("-----------------------------------------------------------");
                            initialPlayer->CastSpell(initialPlayer, SPELL_VISUAL_FINISH, true);
                        }
                    }

                    sMythicMgr->RewardFinishers(initialPlayers, time, me->GetMapId(), _instance->GetMythicLevel());
                    _instance->FinishMythic();
                    _events.Reset();
                    timeStart = 0;
                    initialPlayers.clear();
                    return;
                }
                if (action > 0 && action != 100)
                {
                    uint8 levelSelected = uint8(action);
                    _instance->StartMythic(levelSelected, me);
                    timeStart = getMSTime();
                    _events.ScheduleEvent(EVENT_UPDATE_TIMER, 30000);
                    _events.ScheduleEvent(EVENT_ANTI_CHEAT, 5000);
                    _events.ScheduleEvent(EVENT_CHECK_AFFIXES, 5000);

                    std::string message = "|TInterface/Icons/inv_misc_key_02:32:32:0:-1|t Mythic Level: " + std::to_string(levelSelected);
                    Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                    if (!PlayerList.isEmpty())
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            if (Player* player = i->GetSource())
                                if (!player->IsGameMaster())
                                {
                                    initialPlayers.insert(player->GetGUID());
                                    ChatHandler handler(player->GetSession());

                                    if (Quest const* qGold = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_GOLD, me->GetMapId()))
                                        if (Quest const* qSilver = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_SILVER, me->GetMapId()))
                                            if (Quest const* qBronze = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_BRONZE, me->GetMapId()))
                                            {
                                                player->RemoveRewardedQuest(qBronze->GetQuestId());
                                                player->RemoveRewardedQuest(qSilver->GetQuestId());
                                                player->RemoveRewardedQuest(qGold->GetQuestId());
                                                player->RemoveActiveQuest(qBronze->GetQuestId(), false);
                                                player->RemoveActiveQuest(qSilver->GetQuestId(), false);
                                                player->RemoveActiveQuest(qGold->GetQuestId(), false);

                                                for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
                                                {
                                                    uint32 logQuest = player->GetQuestSlotQuestId(slot);
                                                    if (logQuest == qBronze->GetQuestId() || logQuest == qGold->GetQuestId() || logQuest == qSilver->GetQuestId())
                                                        player->SetQuestSlot(slot, 0);
                                                }

                                                player->AddQuest(qGold, me);
                                            }

                                    handler.SendSysMessage("----------------- Mythic Dungeon Started -----------------");
                                    handler.SendSysMessage(message.c_str());
                                    handler.SendSysMessage("|TInterface/Icons/spell_holy_borrowedtime:32:32:0:-1|t Time Info");
                                    std::string bestTimeString =
                                        "|TInterface/Icons/inv_misc_coin_17:32:32:0:-1|t Gold Reward: Faster than "
                                        + sMythicMgr->msecToMinSecTimeString(sMythicMgr->GetTimeForRewardLevel(CHALLENGE_REWARD_GOLD, me->GetMapId()))
                                        + " Minutes";
                                    handler.SendSysMessage(bestTimeString.c_str());

                                    bestTimeString =
                                        "|TInterface/Icons/inv_misc_coin_18:32:32:0:-1|t Silver Reward: Faster than "
                                        + sMythicMgr->msecToMinSecTimeString(sMythicMgr->GetTimeForRewardLevel(CHALLENGE_REWARD_SILVER, me->GetMapId()))
                                        + " Minutes";
                                    handler.SendSysMessage(bestTimeString.c_str());

                                    bestTimeString =
                                        "|TInterface/Icons/inv_misc_coin_19:32:32:0:-1|t Bronze Reward: Faster than "
                                        + sMythicMgr->msecToMinSecTimeString(sMythicMgr->GetTimeForRewardLevel(CHALLENGE_REWARD_BRONZE, me->GetMapId()))
                                        + " Minutes";
                                    handler.SendSysMessage(bestTimeString.c_str());

                                    bestTimeString =
                                        "|TInterface/Icons/spell_misc_emotionsad:32:32:0:-1|t Consolation Reward: If you need longer than "
                                        + sMythicMgr->msecToMinSecTimeString(sMythicMgr->GetTimeForRewardLevel(CHALLENGE_REWARD_BRONZE, me->GetMapId()))
                                        + " Minutes (Bronze Timer)!";
                                    handler.SendSysMessage(bestTimeString.c_str());

                                    handler.SendSysMessage("-----------------------------------------------------------");
                                    handler.SendSysMessage("----- Active Affixes for this run:");
                                    uint32 cnt = 4;
                                    for (auto itr : sMythicMgr->GetActiveAffixes())
                                    {
                                        if (cnt <= levelSelected)
                                        {
                                            std::string affixString = itr.second.icon + " " + itr.second.name;
                                            handler.SendSysMessage(affixString.c_str());
                                        }
                                        else
                                            break;
                                        cnt += 2;
                                    }
                                    handler.SendSysMessage("-----------------------------------------------------------");
                                    player->TeleportTo(me->GetMapId(), me->GetPosition().GetPositionX(), me->GetPosition().GetPositionY(), me->GetPosition().GetPositionZ(), me->GetOrientation());
                                    player->CastSpell(player, SPELL_VISUAL_FINISH, true);
                                    player->RemoveArenaSpellCooldowns(true);
                                    player->ResetAllPowers();

                                    // Apply Affixes for each player
                                    sMythicMgr->CheckPlayerAffixAuras(player, _instance->GetMythicLevel());
                                }

                    if (GameObject* door = me->FindNearestGameObject(MYTHIC_START_DOOR, 40.0f))
                        door->UseDoorOrButton();
                }
            }

            void UpdateQuests()
            {
                uint32 uniTime = GetMSTimeDiffToNow(timeStart);
                Quest const* qGold = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_GOLD, me->GetMapId());
                Quest const* qSilver = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_SILVER, me->GetMapId());
                Quest const* qBronze = sMythicMgr->GetQuestForRewardLevel(CHALLENGE_REWARD_BRONZE, me->GetMapId());

                // Time used higher than bronze time
                if (uniTime / IN_MILLISECONDS > sMythicMgr->GetQuestTimeForLevel(CHALLENGE_REWARD_BRONZE, qGold->GetTimeAllowed()) && !sentBronze)
                {
                    for (uint64 currentPlayerGuid : initialPlayers)
                    {
                        Player* currentPlayer = ObjectAccessor::FindPlayer(currentPlayerGuid);
                        if (!currentPlayer)
                            continue;

                        currentPlayer->RemoveRewardedQuest(qBronze->GetQuestId());
                        currentPlayer->RemoveActiveQuest(qBronze->GetQuestId(), false);

                        for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
                        {
                            uint32 logQuest = currentPlayer->GetQuestSlotQuestId(slot);
                            if (logQuest == qBronze->GetQuestId())
                                currentPlayer->SetQuestSlot(slot, 0);
                        }

                        currentPlayer->SendPlaySound(13410, true);
                        me->MonsterWhisper("OUT OF TIME! You did not beat the bronze timer! (Reward reduced)", currentPlayer, true);
                    }

                    sentBronze = true;
                }
                // time used higher than silver time
                else if (uniTime / IN_MILLISECONDS > sMythicMgr->GetQuestTimeForLevel(CHALLENGE_REWARD_SILVER, qGold->GetTimeAllowed()) && !sentSilver)
                {
                    for (uint64 currentPlayerGuid : initialPlayers)
                    {
                        Player* currentPlayer = ObjectAccessor::FindPlayer(currentPlayerGuid);
                        if (!currentPlayer)
                            continue;

                        currentPlayer->RemoveRewardedQuest(qSilver->GetQuestId());
                        currentPlayer->RemoveActiveQuest(qSilver->GetQuestId(), false);

                        for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
                        {
                            uint32 logQuest = currentPlayer->GetQuestSlotQuestId(slot);
                            if (logQuest == qSilver->GetQuestId())
                                currentPlayer->SetQuestSlot(slot, 0);
                        }

                        currentPlayer->AddQuest(qBronze, me);
                        currentPlayer->SendPlaySound(13410, true);
                        me->MonsterWhisper("OUT OF TIME! You did not beat the silver timer! (Reward reduced)", currentPlayer, true);
                    }

                    sentSilver = true;
                }
                // time used higher than gold time
                else if (uniTime / IN_MILLISECONDS > sMythicMgr->GetQuestTimeForLevel(CHALLENGE_REWARD_GOLD, qGold->GetTimeAllowed()) && !sentGold)
                {
                    for (uint64 currentPlayerGuid : initialPlayers)
                    {
                        Player* currentPlayer = ObjectAccessor::FindPlayer(currentPlayerGuid);
                        if (!currentPlayer)
                            continue;

                        currentPlayer->RemoveRewardedQuest(qGold->GetQuestId());
                        currentPlayer->RemoveActiveQuest(qGold->GetQuestId(), false);

                        for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
                        {
                            uint32 logQuest = currentPlayer->GetQuestSlotQuestId(slot);
                            if (logQuest == qGold->GetQuestId())
                                currentPlayer->SetQuestSlot(slot, 0);
                        }

                        currentPlayer->AddQuest(qSilver, me);
                        currentPlayer->SendPlaySound(13410, true);
                        me->MonsterWhisper("OUT OF TIME! You did not beat the gold timer! (Reward reduced)", currentPlayer, true);
                    }

                    sentGold = true;
                }
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                if (_instance->IsMythicRunActive() && !initialPlayers.empty())
                    UpdateQuests();

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                    case EVENT_UPDATE_TIMER:
                    {
                        if (!initialPlayers.empty())
                        {
                            for (uint64 currentPlayerGuid : initialPlayers)
                            {
                                Player* currentPlayer = ObjectAccessor::FindPlayer(currentPlayerGuid);
                                if (!currentPlayer)
                                    continue;
                                ChatHandler handler(currentPlayer->GetSession());
                                std::string msg = "|TInterface/Icons/spell_holy_borrowedtime:32:32:0:-1|t Timer: " + sMythicMgr->msecToTimeString(GetMSTimeDiffToNow(timeStart));
                                handler.SendSysMessage(msg.c_str());
                            }
                        }
                        _events.ScheduleEvent(EVENT_UPDATE_TIMER, 30000);
                        break;
                    }
                    case EVENT_ANTI_CHEAT:
                    {
                        Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                        if (!PlayerList.isEmpty())
                            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                if (Player* player = i->GetSource())
                                    if (!player->IsGameMaster())
                                    {
                                        bool playerMatches = false;
                                        for (uint64 initialGuid : initialPlayers)
                                        {
                                            if (initialGuid == player->GetGUID())
                                            {
                                                playerMatches = true;

                                                Player* initial = ObjectAccessor::FindPlayer(initialGuid);
                                                if (!initial)
                                                    continue;

                                                // Check if Affix auras are present
                                                sMythicMgr->CheckPlayerAffixAuras(initial, _instance->GetMythicLevel());
                                            }
                                        }

                                        if (!playerMatches)
                                        {
                                            // Teleport players who were not originally in the starter group
                                            player->TeleportToEntryPoint();
                                            player->GetSession()->SendNotification("You cannot join a mythic group, which already started the run!");
                                        }
                                    }

                        _events.ScheduleEvent(EVENT_ANTI_CHEAT, 5000);
                        break;
                    }
                    case EVENT_CHECK_AFFIXES:
                    {
                        _instance->CheckCreatureAffixes();
                        _events.ScheduleEvent(EVENT_CHECK_AFFIXES, 1000);
                        break;
                    }
                    default:
                        break;
                    }
                }
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
            uint32 timeStart;
            std::set<uint64> initialPlayers;
            bool sentGold = false;
            bool sentSilver = false;
            bool sentBronze = false;
        };

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            player->PlayerTalkClass->ClearMenus();
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "------------ Todays Affixes:", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            uint32 levelCounter = 4;
            for (auto itr : sMythicMgr->GetActiveAffixes())
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, itr.second.icon+" "+ itr.second.name+" - Level " + std::to_string(levelCounter) + "+", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_AFFIX_INFO);
                levelCounter += 2;
            }
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_book_03:32:32:-30:-1|t Show Rewards in detail...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SHOW_REWARD_LEVELS);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_book_03:32:32:-30:-1|t Show Affixes Description...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_AFFIX_INFO);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            uint32 goldTime = sMythicMgr->GetMythicBestTimeForMap(creature->GetMapId());
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/achievement_pvp_a_01:32:32:-30:-1|t Map Gold Time: " + sMythicMgr->msecToMinSecTimeString(goldTime) + " Min.", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MY_TIMES);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/achievement_pvp_a_01:32:32:-30:-1|t Show best runs on this map...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MY_TIMES);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);

            uint8 highestLevel = sMythicMgr->GetHighestLevelForGUID(player->GetGUID());
            if (player->IsGameMaster())
                highestLevel = MYTHIC_LEVEL_MAX - 1;
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_key_02:32:32:-30:-1|t Your highest Level: " + std::to_string(highestLevel), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_key_02:32:32:-30:-1|t Unlocks Levels up to " + std::to_string(std::min(highestLevel + MYTHIC_UNLOCK_RANGE, MYTHIC_LEVEL_MAX - 1)), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
            if (!creature->GetInstanceScript()->IsMythicRunActive())
            {
                if (!sMythicMgr->HasKeyStoneForDungeon(player, creature->GetMapId()))
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_key_15:32:32:-30:-1|t Need Keystone to start!", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                }
                else
                {
                    for (uint8 i = 1; i < std::min(uint8(highestLevel + MYTHIC_UNLOCK_RANGE + 1), uint8(MYTHIC_LEVEL_MAX)); i++)
                    {
                        uint8 activeAffixes = 0;
                        if (i >= 12)
                            activeAffixes = 5;
                        else if (i >= 10)
                            activeAffixes = 4;
                        else if (i >= 8)
                            activeAffixes = 3;
                        else if (i >= 6)
                            activeAffixes = 2;
                        else if (i >= 4)
                            activeAffixes = 1;
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/achievement_arena_2v2_1:32:32:-30:-1|t Start: Level " + std::to_string(i) + " (" + std::to_string(activeAffixes) + " Affixes)", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + i);
                    }
                }
            }

            player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            if (action == GOSSIP_OPTION_NO_ACTION)
            {
                player->PlayerTalkClass->SendCloseGossip();
                return true;
            }

            if (action == GOSSIP_SHOW_MAIN_MENU)
            {
                OnGossipHello(player, creature);
                return true;
            }

            if (action == GOSSIP_ACTION_SHOW_REWARD_LEVELS)
            {
                for (uint8 i = 1; i < uint8(MYTHIC_LEVEL_MAX); i++)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_01:32:32:-30:-1|t Rewards for Level " + std::to_string(i), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL + i);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MAIN_MENU);
                player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
                return true;
            }

            if (action > GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL && action <= GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL + 15)
            {
                uint8 level = action - GOSSIP_ACTION_SHOW_REWARDS_FOR_LEVEL;
                MythicItemRewards rewards = sMythicMgr->GetMythicRewardItemsForLevel(level);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "------------ Rewards for Level " + std::to_string(level), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                for (auto staticReward : rewards.items)
                {
                    uint32 itemEntry = staticReward.first;
                    uint32 amount = staticReward.second;
                    ItemTemplate const* item = sObjectMgr->GetItemTemplate(itemEntry);
                    if (item)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_01:32:32:-30:-1|t " + std::to_string(amount) + "x " + item->Name1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "------------ Bonus for finishing in time", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                ItemTemplate const* item = sObjectMgr->GetItemTemplate(rewards.goldItemId);
                if (item)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_17:32:32:-30:-1|t " + std::to_string(rewards.goldItemCount) + "x " + item->Name1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                item = sObjectMgr->GetItemTemplate(rewards.silverItemId);
                if (item)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_18:32:32:-30:-1|t " + std::to_string(rewards.silverItemCount) + "x " + item->Name1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                item = sObjectMgr->GetItemTemplate(rewards.bronzeItemId);
                if (item)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "|TInterface/Icons/inv_misc_coin_19:32:32:-30:-1|t " + std::to_string(rewards.bronzeItemCount) + "x " + item->Name1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);

                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SHOW_REWARD_LEVELS);
                player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
                return true;
            }

            if (action == GOSSIP_SHOW_MY_TIMES)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "|TInterface/Icons/inv_misc_coin_17:32:32:-30:-1|t |c00e53903Overall|r best runs for this map:", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                for (uint32 level = 1; level < MYTHIC_LEVEL_MAX; level++)
                {
                    uint64 time = sMythicMgr->GetPlayerBestTimeForMapAndLevel(player->GetGUID(), creature->GetMapId(), level, true);
                    if (time)
                    {
                        std::string msg = "|TInterface/Icons/spell_holy_borrowedtime:24:24:-30:-1|t Level " + std::to_string(level) + ": " + sMythicMgr->msecToMinSecTimeString(time) + " Minutes";
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, msg, GOSSIP_SENDER_MAIN, GOSSIP_SHOW_TIME_DETAIL_BEST + level);
                    }
                    else
                    {
                        std::string msg = "|TInterface/Icons/spell_holy_borrowedtime:24:24:-30:-1|t Level " + std::to_string(level) + ": --------";
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, msg, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                    }
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, sMythicMgr->GetClassIcon(player->getClass()) + "|c00e53903Your|r best runs (|c00e53903" + player->GetName() + "|r)", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                for (uint32 level = 1; level < MYTHIC_LEVEL_MAX; level++)
                {
                    uint64 time = sMythicMgr->GetPlayerBestTimeForMapAndLevel(player->GetGUID(), creature->GetMapId(), level);
                    if (time)
                    {
                        std::string msg = "|TInterface/Icons/spell_holy_borrowedtime:24:24:-30:-1|t Level " + std::to_string(level) + ": " + sMythicMgr->msecToMinSecTimeString(time) + " Minutes";
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, msg, GOSSIP_SENDER_MAIN, GOSSIP_SHOW_TIME_DETAIL + level);
                    }
                    else
                    {
                        std::string msg = "|TInterface/Icons/spell_holy_borrowedtime:24:24:-30:-1|t Level " + std::to_string(level) + ": --------";
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, msg, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                    }
                }

                //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MAIN_MENU);
                player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT_BEST_TIMES, creature->GetGUID());
                return true;
            }
            if (action > GOSSIP_SHOW_TIME_DETAIL && action < GOSSIP_SHOW_TIME_DETAIL + MYTHIC_LEVEL_MAX)
            {
                uint32 level = action - GOSSIP_SHOW_TIME_DETAIL;
                std::set<uint64> bestGuids = sMythicMgr->GetGUIDsForMapAndLevel(player->GetGUID(), creature->GetMapId(), level);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_key_02:32:32:-30:-1|t Mythic Level: " + std::to_string(level), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                uint64 time = sMythicMgr->GetPlayerBestTimeForMapAndLevel(player->GetGUID(), creature->GetMapId(), level);
                if (time)
                {
                    std::string msg = "|TInterface/Icons/spell_holy_borrowedtime:32:32:-30:-1|t Time: " + sMythicMgr->msecToMinSecTimeString(time) + " Minutes";
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, msg, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                std::string line = "";
                for (uint64 guid : bestGuids)
                {
                    std::string playerName = "";
                    uint8 classId = 0;
                    if (sMythicMgr->GetPlayerNameClassByGUID(guid, playerName, classId))
                        line = sMythicMgr->GetClassIcon(classId) + " " + playerName;
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, line, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MY_TIMES);
                player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
                return true;
            }
            if (action > GOSSIP_SHOW_TIME_DETAIL_BEST && action < GOSSIP_SHOW_TIME_DETAIL_BEST + MYTHIC_LEVEL_MAX)
            {
                uint32 level = action - GOSSIP_SHOW_TIME_DETAIL_BEST;
                std::set<uint64> bestGuids = sMythicMgr->GetGUIDsForMapAndLevel(player->GetGUID(), creature->GetMapId(), level, true);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/Icons/inv_misc_key_02:32:32:-30:-1|t Mythic Level: " + std::to_string(level), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                uint64 time = sMythicMgr->GetPlayerBestTimeForMapAndLevel(player->GetGUID(), creature->GetMapId(), level, true);
                if (time)
                {
                    std::string msg = "|TInterface/Icons/spell_holy_borrowedtime:32:32:-30:-1|t Time: " + sMythicMgr->msecToMinSecTimeString(time) + " Minutes";
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, msg, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                std::string line = "";
                for (uint64 guid : bestGuids)
                {
                    std::string playerName = "";
                    uint8 classId = 0;
                    if (sMythicMgr->GetPlayerNameClassByGUID(guid, playerName, classId))
                        line = sMythicMgr->GetClassIcon(classId) + " " + playerName;
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, line, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MY_TIMES);
                player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
                return true;
            }
            if (action == GOSSIP_SHOW_AFFIX_INFO)
            {
                for (MythicAffixEntry affixEntry : sMythicMgr->GetAffixStore())
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, affixEntry.icon + " " + affixEntry.name, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, affixEntry.text, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "---------------------------------------", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NO_ACTION);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:32:32:-30:-1|t Back...", GOSSIP_SENDER_MAIN, GOSSIP_SHOW_MAIN_MENU);
                player->SEND_GOSSIP_MENU(GOSSIP_NPC_TEXT, creature->GetGUID());
                return true;
            }

            if (action >= GOSSIP_ACTION_INFO_DEF + 1)
            {
                player->PlayerTalkClass->SendCloseGossip();
                uint32 selectedLevel = action - 1000;

                InstanceScript* instance = creature->GetInstanceScript();
                if (!instance)
                    return false;

                if (!sMythicMgr->HasKeyStoneForDungeon(player, creature->GetMapId()))
                {
                    creature->MonsterSay("You have no keystone for this dungeon! Give leader to a player with the key!", LANG_UNIVERSAL, player);
                    return false;
                }
                if (instance->IsMythicRunActive())
                {
                    creature->MonsterSay("There is already a mythic run active!", LANG_UNIVERSAL, player);
                    return false;
                }
                for (uint32 i = 0; i < instance->GetEncounterCount(); i++)
                {
                    if (instance->GetBossState(i) == DONE)
                    {
                        creature->MonsterSay("Dungeon is not reset correctly! Please reset the lockout by leaving the instance, setting to (non)heroic and then back to mythic!", LANG_UNIVERSAL, player);
                        return false;
                    }
                }
                uint8 possibleLevel = std::min(sMythicMgr->GetHighestLevelForGUID(player->GetGUID()) + MYTHIC_UNLOCK_RANGE, MYTHIC_LEVEL_MAX - 1);
                if (possibleLevel < selectedLevel)
                {
                    std::stringstream error;
                    error << "You can only start dungeons up to level " << std::to_string(possibleLevel) << "! Give lead to a player who can start higher levels!";
                    creature->MonsterSay(error.str().c_str(), LANG_UNIVERSAL, player);
                    return false;
                }
                Group* group = player->GetGroup();
                if (!group)
                {
                    creature->MonsterSay("You must be in a group to start the dungeon!", LANG_UNIVERSAL, player);
                    return false;
                }
                if (group->GetLeaderGUID() != player->GetGUID())
                {
                    creature->MonsterSay("Only the group leader can start the mythic dungeon!", LANG_UNIVERSAL, player);
                    return false;
                }
                // Check group members
                uint32 healCount = 0;
                uint32 dpsCount = 0;
                uint32 tankCount = 0;
                for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
                {
                    Player* member = itr->GetSource();
                    // For some Reason the member is still not null even when offline
                    if (member)
                        member = ObjectAccessor::FindPlayer(member->GetGUID());
                    if (!member)
                    {
                        creature->MonsterSay("A group member is offline!", LANG_UNIVERSAL, player);
                        return false;
                    }
                    if (member->GetMapId() != player->GetMapId())
                    {
                        creature->MonsterSay("Not all group members are in the instance!", LANG_UNIVERSAL, player);
                        return false;
                    }

                    if (member->HasHealSpec())
                        healCount++;
                    else if (member->HasTankSpec())
                        tankCount++;
                    else
                        dpsCount++;
                }

                if (healCount != 1 || tankCount != 1)
                {
                    creature->MonsterSay("You need 1 Tank and 1 Healer to start the mythic run!", LANG_UNIVERSAL, player);
                    return false;
                }
                creature->AI()->DoAction(selectedLevel);
                return true;
            }
            return true;
        }

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_mythic_plus_controllerAI(creature);
        }
};

class spell_mythic_bursting_aura : public SpellScriptLoader
{
    public:
        spell_mythic_bursting_aura() : SpellScriptLoader("spell_mythic_bursting_aura") { }

        class spell_mythic_bursting_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mythic_bursting_aura_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(MYTHIC_SPELL_BURSTING_DOT))
                    return false;
                return true;
            }

            void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEATH)
                    return;

                PreventDefaultAction();
                if (InstanceScript* instance = GetTarget()->GetInstanceScript())
                {
                    Map::PlayerList const &PlayerList = GetTarget()->GetMap()->GetPlayers();
                    if (!PlayerList.isEmpty())
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            if (Player* player = i->GetSource())
                                if (!player->IsGameMaster() && GetTarget()->IsWithinDist(player, 55.0f))
                                {
                                    int32 bp0 = player->CountPctFromMaxHealth(6);
                                    CustomSpellValues spellMod;
                                    spellMod.AddSpellMod(SPELLVALUE_BASE_POINT0, bp0);
                                    GetTarget()->CastCustomSpell(MYTHIC_SPELL_BURSTING_DOT, spellMod, player, TRIGGERED_FULL_MASK);
                                    if (Aura* aur = player->GetAura(MYTHIC_SPELL_BURSTING_DOT, GetTarget()->GetGUID()))
                                        aur->SetDuration(3000);
                                }
                }
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_mythic_bursting_aura_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mythic_bursting_aura_AuraScript();
        }
};

class spell_mythic_replication_aura : public SpellScriptLoader
{
    public:
        spell_mythic_replication_aura() : SpellScriptLoader("spell_mythic_replication_aura") { }

        class spell_mythic_replication_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mythic_replication_aura_AuraScript);

            void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEATH)
                    return;

                if (InstanceScript* instance = GetTarget()->GetInstanceScript())
                {
                    // Prevent from spawning if players not fighting this npc
                    if (GetTarget()->SelectNearestPlayer(40.f))
                        if (roll_chance_i(25.f))
                        {
                            GetTarget()->SummonCreature(NPC_MYTHIC_REPLICATING_ADD, GetTarget()->GetPosition(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000);
                            std::list<Creature*> templist;

                            {
                                CellCoord pair(acore::ComputeCellCoord(GetTarget()->GetPositionX(), GetTarget()->GetPositionY()));
                                Cell cell(pair);
                                cell.SetNoCreate();

                                acore::AllFriendlyCreaturesInGrid check(GetTarget());
                                acore::CreatureListSearcher<acore::AllFriendlyCreaturesInGrid> searcher(GetTarget(), templist, check);

                                TypeContainerVisitor<acore::CreatureListSearcher<acore::AllFriendlyCreaturesInGrid>, GridTypeMapContainer> cSearcher(searcher);

                                cell.Visit(pair, cSearcher, *(GetTarget()->GetMap()), *GetTarget(), GetTarget()->GetGridActivationRange());
                            }

                            if (templist.empty())
                                return;

                            for (std::list<Creature*>::const_iterator i = templist.begin(); i != templist.end(); ++i)
                                if ((*i) && GetTarget()->GetGUID() != (*i)->GetGUID() && GetTarget()->IsWithinDistInMap((*i), 30.f))
                                    (*i)->RemoveAurasDueToSpell(MYTHIC_SPELL_REPLICATION_AURA, 0, 0, AURA_REMOVE_BY_EXPIRE);
                        }
                }
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_mythic_replication_aura_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mythic_replication_aura_AuraScript();
        }
};

class spell_mythic_corruption_aura : public SpellScriptLoader
{
    public:
        spell_mythic_corruption_aura() : SpellScriptLoader("spell_mythic_corruption_aura") { }

        class spell_mythic_corruption_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mythic_corruption_aura_AuraScript);

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();

                if (InstanceScript* instance = GetTarget()->GetInstanceScript())
                {
                    if (!instance->IsMythicRunActive())
                    {
                        GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_EXPLOSIVE_AURA);
                        return;
                    }

                    if (Unit* target = GetTarget())
                    {
                        float chance = 25.f;
                        if (Player* pl = target->ToPlayer())
                            chance = pl->HasCasterSpec() || pl->HasHealSpec() ? 20.f : 25.f;
                        if (sureProc || (roll_chance_f(chance) && target->IsInCombat()))
                        {
                            if (target->HasAuraType(SPELL_AURA_TRANSFORM) || target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_FLEEING) || (target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_STUNNED) && target->HasAuraWithMechanic(1 << MECHANIC_STUN)))
                            {
                                sureProc = true;
                                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                                return;
                            }
                            else if (GetTarget()->HasAura(MYTHIC_SPELL_PETRYFYING_GRIP))
                            {
                                sureProc = true;
                                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                                return;
                            }
                            if (TempSummon* cr = target->SummonCreature(NPC_MYTHIC_EXPLOSION_TRIGGER, target->GetPosition(), TEMPSUMMON_TIMED_DESPAWN, 5000))
                            {
                                cr->SetReactState(REACT_PASSIVE);
                                cr->SetInCombatWithZone();
                                sureProc = false;
                                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(10000, 20000));
                            }
                        }
                    }
                }
                else
                    GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_EXPLOSIVE_AURA);
            }
        private:
            bool sureProc = false;

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_corruption_aura_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mythic_corruption_aura_AuraScript();
        }
};

class spell_mythic_fiery_orb_aura : public SpellScriptLoader
{
    public:
        spell_mythic_fiery_orb_aura() : SpellScriptLoader("spell_mythic_fiery_orb_aura") { }

        class spell_mythic_fiery_orb_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mythic_fiery_orb_aura_AuraScript);

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();

                if (!GetTarget()->IsInCombat() || !GetTarget()->GetVictim())
                {
                    const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(3000);
                    return;
                }

                if (InstanceScript* instance = GetTarget()->GetInstanceScript())
                {
                    if (GetTarget()->GetTypeId() == TYPEID_UNIT && GetTarget()->GetVictim()->GetTypeId() == TYPEID_PLAYER)
                        if (Unit* target = GetTarget()->ToCreature()->AI()->SelectTarget(SELECT_TARGET_FARTHEST, 0, 40.f, true))
                        {
                            if (target->HasAuraType(SPELL_AURA_TRANSFORM) || target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_FLEEING) || (target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_STUNNED) && target->HasAuraWithMechanic(1 << MECHANIC_STUN)))
                            {
                                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                            }
                            else if (GetTarget()->HasAura(MYTHIC_SPELL_PETRYFYING_GRIP) || target->HasAura(MYTHIC_SPELL_GIFT_OF_THARON_JA))
                            {
                                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                            }
                            else if (target->HasAuraType(SPELL_AURA_PHASE))
                            {
                                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                            }
                            else
                            {
                                target->SummonCreature(NPC_MYTHIC_FIERY_ORB, target->GetPosition(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 3000);
                                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(18000);
                            }
                        }
                }
                else
                    GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_FIERY_ORB);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_fiery_orb_aura_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mythic_fiery_orb_aura_AuraScript();
        }
};

class spell_mythic_stoicism_aura : public SpellScriptLoader
{
public:
    spell_mythic_stoicism_aura() : SpellScriptLoader("spell_mythic_stoicism_aura") { }

    class spell_mythic_stoicism_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_stoicism_aura_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();

            if (!GetTarget()->IsInCombat())
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(3000, 6000));
                return;
            }

            if (InstanceScript* instance = GetTarget()->GetInstanceScript())
            {
                if (!instance->IsMythicRunActive())
                {
                    GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_STOICISM_AURA);
                    return;
                }

                if (Unit* target = GetTarget())
                {
                    if (target->HasAuraType(SPELL_AURA_TRANSFORM) || target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_FLEEING) || (target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_STUNNED) && target->HasAuraWithMechanic(1 << MECHANIC_STUN)))
                    {
                        const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                    }
                    else if (GetTarget()->HasAura(MYTHIC_SPELL_PETRYFYING_GRIP) || target->HasAura(MYTHIC_SPELL_GIFT_OF_THARON_JA))
                    {
                        const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                    }
                    else if (target->HasAura(MYTHIC_SPELL_PETRYFYING_GRIP))
                    {
                        const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                    }
                    else if (target->HasAuraType(SPELL_AURA_PHASE))
                    {
                        const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                    }
                    else
                    {
                        Position pos;
                        target->GetRandomPoint(target->GetPosition(), 20.f, pos);
                        if (!target->IsWithinLOS(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), LINEOFSIGHT_ALL_CHECKS))
                            pos.Relocate(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation());

                        if (TempSummon* cr = target->SummonCreature(NPC_MYTHIC_GATEWAY, pos, TEMPSUMMON_TIMED_DESPAWN, 5000))
                        {
                            cr->SetReactState(REACT_PASSIVE);
                            const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(20000, 35000));
                        }
                    }
                }
            }
            else
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_STOICISM_AURA);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_stoicism_aura_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_stoicism_aura_AuraScript();
    }
};

class spell_mythic_lich_kings_blessing_aura : public SpellScriptLoader
{
public:
    spell_mythic_lich_kings_blessing_aura() : SpellScriptLoader("spell_mythic_lich_kings_blessing_aura") { }

    class spell_mythic_lich_kings_blessing_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_lich_kings_blessing_aura_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();

            if (!GetTarget()->IsInCombat() || !GetTarget()->GetVictim() || !GetTarget()->IsAlive()
                || GetTarget()->GetVictim()->GetTypeId() != TYPEID_PLAYER)
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(3000, 10000));
                return;
            }

            if (roll_chance_f(25.f))
            {
                if (InstanceScript* instance = GetTarget()->GetInstanceScript())
                {
                    CustomSpellValues val;
                    val.AddSpellMod(SPELLVALUE_BASE_POINT0, 50);
                    val.AddSpellMod(SPELLVALUE_BASE_POINT1, 60);
                    val.AddSpellMod(SPELLVALUE_BASE_POINT2, -75);
                    GetTarget()->CastCustomSpell(MYTHIC_SPELL_UNHOLY_POWER, val, GetTarget());

                    CustomSpellValues val2;
                    val2.AddSpellMod(SPELLVALUE_BASE_POINT0, 150);
                    val2.AddSpellMod(SPELLVALUE_BASE_POINT1, 100);
                    GetTarget()->CastCustomSpell(MYTHIC_SPELL_UNHOLY_POWER_ATSP, val2, GetTarget(), TRIGGERED_FULL_MASK);
                    if (Aura* atsp = GetTarget()->GetAura(MYTHIC_SPELL_UNHOLY_POWER_ATSP))
                        atsp->SetDuration(10000);

                    if (Aura* visual = GetTarget()->AddAura(MYTHIC_SPELL_UNHOLY_POWER_VSL, GetTarget()))
                        visual->SetDuration(10000);

                    const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(20000, 35000));
                    return;
                }
                else
                    GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_LICH_KINGS_BLESSING_AURA);
            }

            const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(3000, 13000));
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_lich_kings_blessing_aura_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_lich_kings_blessing_aura_AuraScript();
    }
};

class spell_mythic_frenzy_aura : public SpellScriptLoader
{
public:
    spell_mythic_frenzy_aura() : SpellScriptLoader("spell_mythic_frenzy_aura") { }

    class spell_mythic_frenzy_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_frenzy_aura_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();

            if (!GetTarget()->IsInCombat() || !GetTarget()->GetVictim())
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(1000);
                return;
            }

            if (GetTarget()->GetHealthPct() <= 30.f)
            {
                GetTarget()->CastSpell(GetTarget(), MYTHIC_SPELL_FRENZY, true);
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(5000);
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_frenzy_aura_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_frenzy_aura_AuraScript();
    }
};

class spell_mythic_resisting_aura : public SpellScriptLoader
{
public:
    spell_mythic_resisting_aura() : SpellScriptLoader("spell_mythic_resisting_aura") { }

    class spell_mythic_resisting_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_resisting_aura_AuraScript);

        void HandlePeriodic(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();

            if (!GetTarget()->IsInCombat() || !GetTarget()->GetVictim())
                return;

            if (GetTarget()->GetHealthPct() <= 50.f && !GetTarget()->HasAura(MYTHIC_SPELL_RESISTING))
                GetTarget()->CastSpell(GetTarget(), MYTHIC_SPELL_RESISTING, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_resisting_aura_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_resisting_aura_AuraScript();
    }
};

class spell_mythic_necrotic_overflow_aura : public SpellScriptLoader
{
public:
    spell_mythic_necrotic_overflow_aura() : SpellScriptLoader("spell_mythic_necrotic_overflow_aura") { }

    class spell_mythic_necrotic_overflow_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_necrotic_overflow_aura_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();

            if (!GetTarget()->IsInCombat())
                return;

            if (!GetTarget()->SelectNearestPlayer(40.f))
                return;

            if (GetTarget()->HasAura(MYTHIC_SPELL_UNHOLY_POWER))
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(10000);
                return;
            }

            const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(5000, 13000));

            if (InstanceScript* instance = GetTarget()->GetInstanceScript())
                GetTarget()->CastCustomSpell(MYTHIC_SPELL_UNENDING_PAIN, SPELLVALUE_BASE_POINT0, 1000, GetTarget(), TRIGGERED_FULL_MASK);
            else
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_OVERFLOW_AURA_NEW);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_necrotic_overflow_aura_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_necrotic_overflow_aura_AuraScript();
    }
};

class spell_mythic_overflow_aura : public SpellScriptLoader
{
public:
    spell_mythic_overflow_aura() : SpellScriptLoader("spell_mythic_overflow_aura") { }

    class spell_mythic_overflow_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_overflow_aura_AuraScript);

        bool CheckProc(ProcEventInfo& eventInfo)
        {
            if (!GetTarget()->GetInstanceScript())
            {
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_OVERFLOW_AURA);
                return false;
            }
            if (eventInfo.GetHealInfo()->GetHeal() > 0)
                return true;
            return false;
        }

        void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& procInfo)
        {
            PreventDefaultAction();

            Unit* target = GetTarget();

            if (target->IsFullHealth() && target->IsInCombat())
            {
                int32 amount = procInfo.GetHealInfo()->GetHeal();

                if (Aura* aur = target->GetAura(SPELL_MYTHIC_ABSORB_HEAL, target->GetGUID()))
                {
                    if (AuraEffect* aurEff = aur->GetEffect(EFFECT_1))
                        aurEff->ChangeAmount(aurEff->GetAmount() + amount * 2);

                    aur->RefreshDuration();
                }
                else
                {
                    if (Aura* aur = target->AddAura(SPELL_MYTHIC_ABSORB_HEAL, target))
                    {
                        if (AuraEffect* aurEff = aur->GetEffect(EFFECT_1))
                            aurEff->ChangeAmount(amount);

                        aur->SetDuration(2 * MINUTE * IN_MILLISECONDS);
                        aur->SetMaxDuration(2 * MINUTE * IN_MILLISECONDS);
                    }
                }
            }
        }

        void HandlePeriodic(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();

            if (InstanceScript* instance = GetTarget()->GetInstanceScript())
            {
                if (!GetTarget()->IsInCombat())
                    GetTarget()->RemoveAurasDueToSpell(SPELL_MYTHIC_ABSORB_HEAL);
            }
            else
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_OVERFLOW_AURA);
        }

        void Register()
        {
            OnEffectProc += AuraEffectProcFn(spell_mythic_overflow_aura_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            DoCheckProc += AuraCheckProcFn(spell_mythic_overflow_aura_AuraScript::CheckProc);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_overflow_aura_AuraScript::HandlePeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_overflow_aura_AuraScript();
    }

};

class spell_mythic_tank_threat : public SpellScriptLoader
{
public:
    spell_mythic_tank_threat() : SpellScriptLoader("spell_mythic_tank_threat") { }

    class spell_mythic_tank_threat_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_tank_threat_AuraScript);

        void HandlePeriodic(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();
            InstanceScript* instance = GetTarget()->GetInstanceScript();

            if (!instance || !GetTarget()->ToPlayer()->HasTankSpec())
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_TANK_THREAT);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_tank_threat_AuraScript::HandlePeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_tank_threat_AuraScript();
    }

};

class spell_mythic_revive : public SpellScriptLoader
{
public:
    spell_mythic_revive() : SpellScriptLoader("spell_mythic_revive") { }

    class spell_mythic_revive_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_revive_AuraScript);

        void HandlePeriodic(AuraEffect const* /*aurEff*/)
        {
            PreventDefaultAction();
            InstanceScript* instance = GetTarget()->GetInstanceScript();

            if (!instance || !instance->IsMythicRunActive())
            {
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_REVIVE_CHECK);
                return;
            }

            bool revive = false;

            Player* player = GetTarget()->ToPlayer();
            Group* pGroup = player->GetGroup();
            if (pGroup && player)
            {
                for (GroupReference* itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
                    if (Player* groupPlayer = itr->GetSource())
                    {
                        if (groupPlayer->IsInCombat())
                            return;

                        if (groupPlayer->IsAlive() && !groupPlayer->HasAura(MYTHIC_SPELL_REVIVE_SPRINT))
                            return;

                        revive = true;
                    }

                if (revive && !player->IsAlive())
                {
                    player->RemovePet(NULL, PET_SAVE_NOT_IN_SLOT, true);
                    player->BuildPlayerRepop();
                    player->RepopAtGraveyard();
                }
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_revive_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_revive_AuraScript();
    }

};

class spell_mythic_eonars_trial : public SpellScriptLoader
{
public:
    spell_mythic_eonars_trial() : SpellScriptLoader("spell_mythic_eonars_trial") { }

    class spell_mythic_eonars_trial_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_eonars_trial_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            InstanceScript* instance = GetTarget()->GetInstanceScript();

            Player* target = GetTarget()->ToPlayer();
            if (!target)
                return;

            if (!instance || !target || !target->HasHealSpec() || !instance->IsMythicRunActive())
            {
                target->RemoveAurasDueToSpell(MYTHIC_SPELL_EONARS_TRIAL_AURA);
                return;
            }

            if (!target->IsInCombat())
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(5000);
                return;
            }

            if (target->HasAuraType(SPELL_AURA_TRANSFORM) || target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_FLEEING) || (target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_STUNNED) && target->HasAuraWithMechanic(1 << MECHANIC_STUN)))
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                return;
            }

            if (target->HasAura(MYTHIC_SPELL_PETRYFYING_GRIP) || target->HasAura(MYTHIC_SPELL_GIFT_OF_THARON_JA))
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                return;
            }

            if (target->HasAuraType(SPELL_AURA_PHASE))
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                return;
            }

            Position pos;
            target->GetRandomPoint(target->GetPosition(), 15.f, pos);
            if (!target->IsWithinLOS(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), LINEOFSIGHT_ALL_CHECKS))
                pos.Relocate(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation());
            if (TempSummon* cr = target->SummonCreature(NPC_MYTHIC_EONARS_TRIAL, pos, TEMPSUMMON_TIMED_DESPAWN, 10000))
            {
                if (Aura* mist = target->AddAura(MYTHIC_SPELL_MIST_KVALDIR, target))
                    mist->SetDuration(7 * IN_MILLISECONDS);
                cr->SetReactState(REACT_PASSIVE);
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(15000, 20000));
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_eonars_trial_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_eonars_trial_AuraScript();
    }

};

class spell_mythic_beacon_of_hope : public SpellScriptLoader
{
public:
    spell_mythic_beacon_of_hope() : SpellScriptLoader("spell_mythic_beacon_of_hope") { }

    class spell_mythic_beacon_of_hope_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_beacon_of_hope_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            InstanceScript* instance = GetTarget()->GetInstanceScript();

            Player* target = GetTarget()->ToPlayer();

            if (!instance || !target || !target->HasHealSpec() || !instance->IsMythicRunActive())
            {
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_BEACON_OF_HOPE_AURA);
                return;
            }

            if (target->HasAuraType(SPELL_AURA_TRANSFORM) || target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_FLEEING) || (target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_STUNNED) && target->HasAuraWithMechanic(1 << MECHANIC_STUN)))
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                return;
            }

            if (target->HasAuraType(SPELL_AURA_PHASE))
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                return;
            }

            if (target->HasAura(MYTHIC_SPELL_PETRYFYING_GRIP))
            {
                const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(2000);
                return;
            }

            target->CastSpell(target, MYTHIC_SPELL_BEACON_OF_HOPE_TARGET_SELECT, true);

            const_cast<AuraEffect*>(aurEff)->SetPeriodicTimer(urand(30000, 40000));
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_beacon_of_hope_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_beacon_of_hope_AuraScript();
    }

};

class spell_mythic_beacon_of_hope_target : public SpellScriptLoader
{
public:
    spell_mythic_beacon_of_hope_target() : SpellScriptLoader("spell_mythic_beacon_of_hope_target") { }

    class spell_mythic_beacon_of_hope_target_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mythic_beacon_of_hope_target_SpellScript);

        void TargetSelect(std::list<WorldObject*>& targets)
        {
            targets.remove_if([](WorldObject* target)
            {
                if (target->GetTypeId() != TYPEID_PLAYER || !target->ToPlayer()->IsAlive())
                    return true;
                if (target->ToPlayer()->HasAuraType(SPELL_AURA_PHASE))
                    return true;

                return false;
            });
            if (targets.empty())
                return;
            acore::Containers::RandomResizeList(targets, 1);
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mythic_beacon_of_hope_target_SpellScript::TargetSelect, EFFECT_0, TARGET_UNIT_DEST_AREA_ALLY);
        }
    };

    class spell_mythic_beacon_of_hope_target_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mythic_beacon_of_hope_target_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            InstanceScript* instance = GetTarget()->GetInstanceScript();

            if (!instance || !instance->IsMythicRunActive())
            {
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_BEACON_OF_HOPE_TARGET_SELECT);
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_HOLY_ZONE);
                return;
            }

            Player* target = GetTarget()->ToPlayer();
            if (!target)
                return;
            Group* grp = target->GetGroup();
            if (!grp)
                return;

            if (aurEff->GetTickNumber() >= 9)
            {
                for (GroupReference* itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
                {
                    if (Player* grpPlayer = itr->GetSource())
                        if (grpPlayer != target && grpPlayer->IsInMap(target))
                            if (!grpPlayer->IsWithinDist(target, 1.2f) && grpPlayer->IsWithinDist(target, 60.f))
                            {
                                grpPlayer->CastSpell(grpPlayer, MYTHIC_SPELL_HOLY_SHORT_AURA, true);
                                grpPlayer->AddAura(MYTHIC_SPELL_CONFUSE_BEACON, grpPlayer);
                            }
                }

                target->CastSpell(target, MYTHIC_SPELL_HOLY_BOMB, true);
                target->RemoveAurasDueToSpell(MYTHIC_SPELL_BEACON_OF_HOPE_TARGET_SELECT);
                target->RemoveAurasDueToSpell(MYTHIC_SPELL_HOLY_ZONE);
            }
            else
            {
                uint32 counter = 0;
                for (GroupReference* itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
                {
                    if (Player* grpPlayer = itr->GetSource())
                        if (grpPlayer->IsInMap(target))
                            if (grpPlayer->IsWithinDist(target, 1.2f))
                                counter++;
                }

                if (counter >= 5)
                {
                    target->CastSpell(target, MYTHIC_SPELL_HOLY_BOMB, true);
                    target->RemoveAurasDueToSpell(MYTHIC_SPELL_BEACON_OF_HOPE_TARGET_SELECT);
                    target->RemoveAurasDueToSpell(MYTHIC_SPELL_HOLY_ZONE);
                    target->RemoveAurasDueToSpell(MYTHIC_SPELL_BEACON_GROW);
                }
            }
        }

        void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            InstanceScript* instance = GetTarget()->GetInstanceScript();

            if (!instance || !instance->IsMythicRunActive())
            {
                GetTarget()->RemoveAurasDueToSpell(MYTHIC_SPELL_BEACON_OF_HOPE_TARGET_SELECT);
                return;
            }

            Player* target = GetTarget()->ToPlayer();
            if (!target)
                return;

            if (Aura* beaconGrow = target->AddAura(MYTHIC_SPELL_BEACON_GROW, target))
                beaconGrow->SetDuration(9 * IN_MILLISECONDS);

            target->CastSpell(target, MYTHIC_SPELL_HOLY_ZONE, true);
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_mythic_beacon_of_hope_target_AuraScript::HandleApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mythic_beacon_of_hope_target_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_mythic_beacon_of_hope_target_SpellScript();
    }

    AuraScript* GetAuraScript() const
    {
        return new spell_mythic_beacon_of_hope_target_AuraScript();
    }

};

void AddSC_MythicScripts()
{
    new npc_mythic_plus_controller();
    new spell_mythic_bursting_aura();
    new spell_mythic_corruption_aura();
    new spell_mythic_fiery_orb_aura();
    new spell_mythic_replication_aura();
    new spell_mythic_overflow_aura();
    new spell_mythic_necrotic_overflow_aura();
    new spell_mythic_tank_threat();
    new spell_mythic_revive();
    new spell_mythic_frenzy_aura();
    new spell_mythic_resisting_aura();
    new spell_mythic_eonars_trial();
    new npc_mythic_plus_info();
    new spell_mythic_beacon_of_hope();
    new spell_mythic_beacon_of_hope_target();
    new spell_mythic_lich_kings_blessing_aura();
    new spell_mythic_stoicism_aura();
}
