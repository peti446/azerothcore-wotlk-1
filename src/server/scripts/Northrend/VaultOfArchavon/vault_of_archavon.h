/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_ARCHAVON_H
#define DEF_ARCHAVON_H

enum Creatures
{
    CREATURE_ARCHAVON                           = 31125,
    CREATURE_EMALON                             = 33993,
    CREATURE_KORALON                            = 35013,
    CREATURE_TORAVON                            = 38433,
};

enum Data
{
    EVENT_ARCHAVON          = 0,
    EVENT_EMALON            = 1,
    EVENT_KORALON           = 2,
    EVENT_TORAVON           = 3,
    MAX_ENCOUNTER           = 4,
    DATA_STONED             = 5,
};


enum AchievementCriteriaIds
{
    CRITERIA_EARTH_WIND_FIRE_10 = 12018,
    CRITERIA_EARTH_WIND_FIRE_25 = 12019,
};

enum AchievementSpells
{
    SPELL_EARTH_WIND_FIRE_ACHIEVEMENT_CHECK = 68308,
    SPELL_STONED_AURA                       = 63080,
};

enum InstanceEvents
{
    EVENT_INSTANCE_RESET_CHECK = 1
};

enum RequiredAchievementsIds
{
    ACHIEVEMENT_NAXXRAMAS_10 = 576,
    ACHIEVEMENT_NAXXRAMAS_25 = 577,

    ACHIEVEMENT_ULDUAR_KEEPERS_10 = 2890,
    ACHIEVEMENT_ULDUAR_KEEPERS_25 = 2891,

    ACHIEVEMENT_TOC_10 = 3917,
    ACHIEVEMENT_TOC_25 = 3916,
};

#endif
