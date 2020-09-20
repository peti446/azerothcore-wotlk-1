INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588196804255396600');

DROP TABLE IF EXISTS `map_difficulty_data`;
CREATE TABLE IF NOT EXISTS `map_difficulty_data` (
  `mapId` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `difficulty` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `parentDifficulty` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `comment` TEXT,
  PRIMARY KEY (`mapId`, `difficulty`)
) ENGINE=MYISAM;

DROP TABLE IF EXISTS `mythic_dungeon_times`;
CREATE TABLE IF NOT EXISTS `mythic_dungeon_times` (
  `mapId` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `bestTime` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `comment` TEXT,
  `keystone_entry`  INT(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`mapId`)
) ENGINE=MYISAM;

DROP TABLE IF EXISTS `mythic_dungeon_affixes`;
CREATE TABLE IF NOT EXISTS `mythic_dungeon_affixes` (
  `mask` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `icon` VARCHAR(255) NOT NULL DEFAULT 0,
  `infoText` VARCHAR(255) NOT NULL DEFAULT 0,
  `name` TEXT,
  PRIMARY KEY (`mask`)
) ENGINE=MYISAM;

DROP TABLE IF EXISTS `mythic_dungeon_rewards`;
CREATE TABLE IF NOT EXISTS `mythic_dungeon_rewards` (
  `dungeonLevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0,
  `itemId1` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `itemId1Amount` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `itemId2` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `itemId2Amount` INT(10) UNSIGNED NOT NULL DEFAULT 0,  
  `itemId3` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `itemId3Amount` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  
  `bronzeItemId1` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `bronzeItemId1Amount` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `silverItemId1` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `silverItemId1Amount` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `goldItemId1` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `goldItemId1Amount` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`dungeonLevel`)
) ENGINE=MYISAM;

-- Uncomment if you need basic rewards

INSERT INTO `mythic_dungeon_rewards` (`dungeonLevel`, `itemId1`, `itemId1Amount`, `itemId2`, `itemId2Amount`, `itemId3`, `itemId3Amount`, `bronzeItemId1`, `bronzeItemId1Amount`, `silverItemId1`, `silverItemId1Amount`, `goldItemId1`, `goldItemId1Amount`) VALUES 
(1, 49426, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 49426, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 49426, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 49426, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 49426, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 49426, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 49426, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 49426, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 49426, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 49426, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `mythic_dungeon_affixes`;
INSERT INTO `mythic_dungeon_affixes` VALUES 
(1, '|TInterface/Icons/spell_fire_incinerate:32:32:-30:-1|t', 'Each Non-boss enemy killed causes all players to take 16% of their max health for 3 seconds.', '|c00f61f02Bursting|r'),
(2, '|TInterface/Icons/spell_nature_earthquake:32:32:-30:-1|t', 'Periodically, the ground trembles, dealing 24000 damage in an small area after 4 seconds.', '|c00f61f02Explosive|r'),
(4, '|TInterface/Icons/inv_misc_orb_05:32:32:-30:-1|t', 'Bosses spawn a fiery orb every 18 seconds, which periodically damages all players unless killed.', '|c00f61f02Fiery Orb|r'),
(8, '|TInterface/Icons/spell_shadow_summonvoidwalker:32:32:-30:-1|t', 'Non-boss enemies have a chance to summon an Arcane Aberration which divides into 5 small aberrations.', '|c00f61f02Replication|r'),
(16, '|TInterface/Icons/spell_shadow_devouringplague:32:32:-30:-1|t', 'Periodically Non-boss enemies damage nearby players.', '|c00f61f02Necrotic Overflow|r'),
(32, '|TInterface/Icons/spell_fire_firearmor:32:32:-30:-1|t', 'Boss enemies have 30% increased health.', '|c00f61f02Resisting|r'),
(64, '|TInterface/Icons/spell_nature_shamanrage:32:32:-30:-1|t', 'Non-boss enemies get in frenzy under 30% health, which increases nearby enemies attackspeed by 33%.', '|c00f61f02Frenzy|r'),
(128, '|TInterface/Icons/achievement_boss_lichking:32:32:-30:-1|t', 'Non-boss enemies periodically become infused with the Lich Kings Blessing. Infused enemies have 75% reduced movement speed, but deal 150% more physical damage, 50% more magic damage and have 100% more attack speed.', '|c00f61f02Lich Kings Blessing|r'),
(256, '|TInterface/Icons/spell_nature_healingtouch:32:32:-30:-1|t', 'Periodically, Eonar tests your group. If you fail to heal her Tree of Life within 7 seconds, all players get feared.', '|c00f61f02Eonars Trial|r'),
(512, '|TInterface/Icons/ability_paladin_beaconoflight:32:32:-30:-1|t', 'Periodically, a random player will be assigned your party’s Beacon of Hope. Any player not in range of the Beacon of Hope after 9 seconds will fall into despair causing them to become stunned for 6 seconds.', '|c00f61f02Beacon of Hope|r'),
(1024, '|TInterface/Icons/spell_shadow_deathsembrace:32:32:-30:-1|t', 'Periodically, a demonic gateway will open up and a random demon will assault your group.', '|c00f61f02Demonic Gateway|r');

DELETE FROM `command` WHERE `name` LIKE '%mythic%' OR `name` = 'affixes';
INSERT INTO `command` VALUES 
('mythic', 0, 'Syntax: .mythicon\r\n\r\nSets your (and your groups) Dungeon Difficulty to mythic.'),
('instance mythicinfo', 2, 'Syntax: .instance mythicinfo\r\n\r\nShows information about the current group running this mythic dungeon.'),
('reload mythic', 3, 'Syntax: .reload mythic\r\n\r\nReloads mythic rewards, times and affixes.'),
('affixes', 3, 'Syntax: .affixes\r\n\r\nChanges the current active affixes.');

-- Bursting/Impaling Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100200;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Impaling');

-- Explosive Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100201;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100201, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Explosive Affix');

-- Fiery Orb Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100202;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100202, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 18000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Fiery Orb Affix');

-- Replication Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100203;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100203, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Replication');

-- Stack Aura: 10% more hp 17% more dmg
DELETE FROM `spell_dbc` WHERE `Id`=100204;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100204, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 15, -1, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 10, 17, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 133, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Stack Aura');

-- Stack Aura TRASH: 1% more hp 6% more dmg
DELETE FROM `spell_dbc` WHERE `Id`=100206;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100206, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 15, -1, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 6, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 79, 133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Stack Aura');

-- Overflow Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100205;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100205, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 557056, 100, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 4, 226, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Overflow Affix');

-- Necrotic Overflow Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100207;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100207, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Fiery Orb Affix');


-- Tank Threat Increase Aura
DELETE FROM `spell_dbc` WHERE `Id`=100208;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100208, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 200, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 10, 226, 0, 0, 10000, 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Explosive Affix');

-- Player Revive Check Aura
DELETE FROM `spell_dbc` WHERE `Id`=100209;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100209, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Revive Auto Check');

-- Stack Aura ICC Dungeons: 8% more hp 14% more dmg
DELETE FROM `spell_dbc` WHERE `Id`=100210;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100210, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 15, -1, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 8, 14, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 133, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Stack Aura');

-- Tyrannical Affix: 30% more hp
DELETE FROM `spell_dbc` WHERE `Id`=100212;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100212, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 15, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Tyrannical Aura');

-- Frenzy Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100213;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100213, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Frenzy Affix');

-- Resisting Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100214;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100214, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Frenzy Affix');

-- Eonars Trial Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100215;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100215, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Eonars Trial Affix');

-- Beacon of Hope Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100216;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100216, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Beacon of Hope Affix');

-- Beacon of Hope Affix Aura (Selector)
DELETE FROM `spell_dbc` WHERE `Id`=100217;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100217, 0, 0, 2148008000, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63, 0, 0, 31, 0, 0, 48, 0, 0, 226, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Beacon of Hope Target Selector');

-- Lich Kings Blessing Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100218;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100218, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Lich Kings Blessing Affix');

-- Lich Kings Blessing Cast reduction
DELETE FROM `spell_dbc` WHERE `Id`=100219;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100219, 0, 0, 2148008000, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 1, 0, 0, 0, 0, 0, -75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 'Mythic Plus - Reduce Magic Damage While Blessing');

-- Stoicism Affix Aura
DELETE FROM `spell_dbc` WHERE `Id`=100220;
INSERT INTO `spell_dbc` (`Id`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesExB`, `AttributesExC`, `AttributesExD`, `AttributesExE`, `AttributesExF`, `AttributesExG`, `ShapeshiftMask`, `ShapeshiftExclude`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcTypeMask`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `CumulativeAura`, `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`, `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`, `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`, `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`, `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`, `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`, `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`, `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`, `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`, `EffectSpellClassMaskA_1`, `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`, `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`, `MaxTargets`, `DefenseType`, `PreventionType`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `EffectChainAmplitude_3`, `RequiredAreasID`, `SchoolMask`, `Name_Lang_enUS`) VALUES 
(100220, 0, 0, 2147483712, 65536, 1, 1048576, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Mythic Plus - Eonars Trial Affix');

DELETE FROM `creature_template` WHERE `entry` IN (200000, 200001, 200002, 200003, 200004, 200005, 200006, 200007, 200008, 200009);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES 
(200000, 0, 0, 0, 0, 0, 16616, 0, 0, 0, 'Grand Challenger Kito', 'Mythic Expedition Leader', NULL, 7421, 80, 80, 1, 35, 1, 1, 1.14286, 1, 1, 252, 357, 0, 304, 7.5, 2000, 2000, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 215, 320, 44, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 0.7, 1, 1, 0, 0, 1, 8388624, 0, 'npc_mythic_plus_controller', 0),
(200001, 0, 0, 0, 0, 0, 169, 0, 0, 0, 'Explosion', 'Mythic', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 1.1, 0, 2, 2, 0, 24, 1, 2000, 2000, 1, 33947648, 2048, 0, 0, 0, 0, 0, 0, 1, 1, 0, 10, 1049600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 4, 1, 1, 1, 1, 0, 0, 1, 0, 128, '', 12340),
(200002, 0, 0, 0, 0, 0, 23258, 0, 0, 0, 'Fiery Orb', 'Mythic', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 2000, 1, 262144|524288, 2048, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 3, 1, 1, 0, 0, 1, 634355583, 0, '', 12340),
(200003, 0, 0, 0, 0, 0, 19951, 0, 0, 0, 'Replicating Arcane Aberration', 'Mythic', '', 0, 81, 81, 2, 16, 0, 0.888888, 1.14286, 0.8, 1, 1000, 2000, 0, 1, 6, 2000, 2000, 2, 32832, 2048, 0, 0, 0, 0, 0, 0, 351, 511, 86, 2, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 5, 1, 1, 0, 0, 1, 0, 0, '', 12340),
(200004, 0, 0, 0, 0, 0, 19951, 0, 0, 0, 'Replicated Aberration', 'Mythic', '', 0, 81, 81, 2, 16, 0, 0.3, 0.3, 0.2, 1, 300, 500, 0, 1, 2, 2000, 2000, 2, 32832, 2048, 0, 0, 0, 0, 0, 0, 351, 511, 86, 2, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1, 1, 1, 0, 0, 1, 0, 0, '', 12340),
(200005, 0, 0, 0, 0, 0, 28989, 0, 0, 0, 'Eonar\'s Trial', '', '', 0, 81, 81, 2, 1665, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 353, 512, 112, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1.5, 1, 1, 0, 0, 1, 650854271, 2097152, '', 12340),
(200006, 0, 0, 0, 0, 0, 16616, 0, 0, 0, 'Grand Challenger Kito', 'Mythic Expedition Leader', NULL, 7421, 80, 80, 1, 35, 1, 1, 1.14286, 1.5, 1, 252, 357, 0, 304, 7.5, 2000, 2000, 1, 33536, 2048, 0, 0, 0, 0, 0, 0, 215, 320, 44, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 0.7, 1, 1, 0, 0, 1, 8388624, 0, 'npc_mythic_plus_info', 0),
(200007, 0, 0, 0, 0, 0, 21447, 0, 0, 0, 'Stoic Gaze', 'Mythic', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 2000, 1, 262144|524288, 2048, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 2, 1, 1, 0, 0, 1, 634355583, 0, '', 12340),
(200008, 0, 0, 0, 0, 0, 23258, 0, 0, 0, 'Demonic Gateway', 'Mythic', '', 0, 82, 82, 2, 35, 0, 1, 1.14286, 1.0, 0, 2, 2, 0, 24, 1, 2000, 2000, 1, 33554438, 2048, 0, 0, 0, 0, 0, 0, 1, 1, 0, 10, 1049600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 4, 1, 1, 1, 1, 0, 0, 1, 0, 0, '', 12340),
(200009, 0, 0, 0, 0, 0, 21252, 0, 0, 0, 'Sentinel Sister', 'Mythic', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 0.6, 0, 2, 2, 0, 24, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 100, 1, 1, 0, 0, 1, 0, 0, '', 12340);

UPDATE creature_template cr SET cr.unit_flags = 512+131072 WHERE cr.entry = 200005;
UPDATE creature_template cr SET cr.unit_class = 2 WHERE cr.entry = 200009;

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_mythic_eonars_trial', 'spell_mythic_resisting_aura', 'spell_mythic_frenzy_aura', 'spell_mythic_revive', 'spell_mythic_tank_threat', 'spell_mythic_necrotic_overflow_aura', 'spell_mythic_overflow_aura', 'spell_mythic_bursting_aura', 'spell_mythic_corruption_aura', 'spell_mythic_fiery_orb_aura', 'spell_mythic_replication_aura');
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_mythic_stoicism_aura', 'spell_mythic_beacon_of_hope', 'spell_mythic_beacon_of_hope_target', 'spell_mythic_lich_kings_blessing_aura');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(100200, 'spell_mythic_bursting_aura'),
(100201, 'spell_mythic_corruption_aura'),
(100202, 'spell_mythic_fiery_orb_aura'),
(100203, 'spell_mythic_replication_aura'),
(100205, 'spell_mythic_overflow_aura'),
(100207, 'spell_mythic_necrotic_overflow_aura'),
(100208, 'spell_mythic_tank_threat'),
(100209, 'spell_mythic_revive'),
(100213, 'spell_mythic_frenzy_aura'),
(100214, 'spell_mythic_resisting_aura'),
(100215, 'spell_mythic_eonars_trial'),
(100216, 'spell_mythic_beacon_of_hope'),
(100217, 'spell_mythic_beacon_of_hope_target'),
(100218, 'spell_mythic_lich_kings_blessing_aura'),
(100220, 'spell_mythic_stoicism_aura');

DELETE FROM `gameobject_template` WHERE `entry`=500000;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES 
(500000, 0, 8643, 'Doodad_Mythic_Start_Door', '', '', '', 1.32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);

DELETE FROM `gameobject_template_addon` WHERE `entry`=500000;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`) VALUES 
(500000, 1375, 32, 0, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid`IN(200001);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(200001, 0, 0, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 0, 218, 5255, 3, 24000, 0, 0, 0, 17, 0, 2, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200001, 0, 1, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 0, 86, 6869, 3, 17, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200001, 0, 2, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 0, 11, 71495, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200001, 0, 3, 0, 0, 0, 100, 1, 0000, 0000, 0, 0, 0, 11, 64228, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200001, 0, 4, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 0, 11, 64228, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200001, 0, 5, 0, 0, 0, 100, 1, 2000, 2000, 0, 0, 0, 11, 64228, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200001, 0, 6, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200001, 0, 7, 0, 0, 0, 100, 1, 4000, 4000, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void');

DELETE FROM `smart_scripts` WHERE `entryorguid`IN(200002);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(200002, 0, 0, 0, 0, 0, 100, 1, 1000, 1000, 3000, 3000, 0, 218, 63677, 3, 2000, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 75, 71706, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 3, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 5, 0, 0, 0, 100, 1, 3000, 3000, 3000, 3000, 0, 218, 63677, 3, 2200, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 6, 0, 0, 0, 100, 1, 5000, 5000, 3000, 3000, 0, 218, 63677, 3, 2400, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 7, 0, 0, 0, 100, 1, 6000, 6000, 3000, 3000, 0, 218, 63677, 3, 2600, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 8, 0, 0, 0, 100, 0, 7000, 7000, 1000, 1000, 0, 218, 63677, 3, 2800, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200002, 0, 9, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 75, 72723, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb');

DELETE FROM `smart_scripts` WHERE `entryorguid`IN(200003);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(200003, 0, 0, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 218, 59435, 3, 4000, 50, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200003, 0, 1, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 12, 200004, 6, 3000, 0, 0, 0, 17, 0, 50, 1, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200003, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 12, 200004, 6, 3000, 0, 0, 0, 17, 0, 50, 1, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200003, 0, 3, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 12, 200004, 6, 3000, 0, 0, 0, 17, 0, 50, 1, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200003, 0, 4, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 12, 200004, 6, 3000, 0, 0, 0, 17, 0, 50, 1, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200003, 0, 5, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 12, 200004, 6, 3000, 0, 0, 0, 17, 0, 50, 1, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200003, 0, 6, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb');

DELETE FROM `smart_scripts` WHERE `entryorguid`IN(200004);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(200004, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200004, 0, 1, 0, 0, 0, 100, 1, 20000, 20000, 0, 0, 0, 12, 200003, 6, 3000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200004, 0, 2, 0, 0, 0, 100, 1, 21000, 21000, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void'),
(200004, 0, 3, 0, 0, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 31671, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Corruption Void');

DELETE FROM `smart_scripts` WHERE `entryorguid`IN(200008, 200008*100+00, 200008*100+01);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(200008, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 11, 68424, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200008, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 11, 75033, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200008, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 87, 200008*100+00, 200008*100+01, 200008*100+00, 200008*100+01, 200008*100+00, 200008*100+01, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200008, 9, 3, 0, 1, 0, 100, 0, 4000, 4000, 0, 0, 0, 28, 68424, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),

(200008*100+00, 9, 0, 0, 1, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 200007, 4, 2000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200008*100+01, 9, 0, 0, 1, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 200009, 3, 4000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway');

DELETE FROM `smart_scripts` WHERE `entryorguid`IN(200007);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(200007, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200007, 0, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 11, 41083, 0, 0, 0, 0, 0, 203, 40, 4, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200007, 0, 2, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200007, 0, 3, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway');

DELETE FROM `smart_scripts` WHERE `entryorguid`IN(200009);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(200009, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200009, 0, 1, 0, 0, 0, 100, 1, 500, 500, 0, 0, 0, 11, 64678, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200009, 0, 2, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway'),
(200009, 0, 3, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Demonic Gateway');

DELETE FROM `smart_scripts` WHERE `entryorguid`IN(200005, 200005*100+00);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(200005, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 75, 63771, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 1, 0, 53, 1, 100, 1, 0, 30000, 0, 0, 0, 41, 1500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 2, 0, 53, 1, 100, 1, 0, 30000, 0, 0, 0, 75, 70571, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 3, 0, 53, 1, 100, 1, 0, 30000, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),

(200005, 0, 4, 0, 1, 1, 100, 1, 2300, 2300, 0, 0, 0, 75, 63772, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 5, 0, 1, 1, 100, 1, 4600, 4600, 0, 0, 0, 28, 63771, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),

(200005, 0, 6, 0, 1, 1, 100, 1, 7000, 7000, 0, 0, 0, 80, 200005*100+00, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 7, 0, 31, 0, 100, 1, 35997, 0, 0, 0, 0, 75, 64386, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),

(200005, 0, 8, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),

(200005, 0, 9, 0, 1, 2, 100, 1, 0, 0, 500, 500, 0, 75, 42824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 10, 0, 1, 2, 100, 1, 0, 0, 500, 500, 0, 75, 42824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 11, 0, 1, 2, 100, 1, 0, 0, 500, 500, 0, 75, 42824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 12, 0, 1, 2, 100, 1, 0, 0, 500, 500, 0, 28, 63771, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005, 0, 13, 0, 1, 2, 100, 1, 0, 0, 500, 500, 0, 28, 63772, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),

(200005, 0, 14, 0, 53, 0, 100, 1, 0, 30000, 0, 0, 0, 28, 50203, 0, 0, 0, 0, 0, 17, 0, 200, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),

(200005*100+00, 9, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005*100+00, 9, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005*100+00, 9, 2, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005*100+00, 9, 3, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 11, 35997, 3, 0, 0, 0, 0, 17, 0, 200, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005*100+00, 9, 4, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 75, 42824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005*100+00, 9, 5, 0, 0, 0, 100, 1, 1700, 1700, 0, 0, 0, 75, 42824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005*100+00, 9, 6, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 75, 42824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb'),
(200005*100+00, 9, 7, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 28, 50203, 0, 0, 0, 0, 0, 17, 0, 200, 0, 0, 0, 0, 0, 0, 'Mythic - Fiery Orb');

DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=35997;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES 
(0, 35997, 64, '', '', 'Mythic - Dummy Spell');


DELETE FROM `npc_text` WHERE `ID` IN (600000, 600001);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES 
(600000, 'Welcome to the Mythic Hub $N!', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(600001, 'Click on any entry to get more information!', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

-- ------------- START DUNGEONS
SET @OGUID := 2000000;
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID AND @OGUID + 18;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES 
(@OGUID+0 , 500000, 576, 0, 0, 4, 1, 169.571, -5.27397, -16.6367, 3.14854, -0, -0, -0.999994, 0.00347368, 0, 255, 1, '', 0),
(@OGUID+1 , 500000, 575, 0, 0, 4, 1, 550.785, -327.204, 110.218, 3.13613, -0, -0, -0.999996, -0.00272985, 300, 0, 1, '', 0),
(@OGUID+2 , 500000, 574, 0, 0, 4, 1, 171.487, -80.8314, 12.551, 0.35636, -0, -0, -0.177239, -0.984168, 300, 0, 1, '', 0),
(@OGUID+3 , 500000, 604, 0, 0, 4, 1, 1871.37, 630.769, 176.666, 3.1363, -0, -0, -0.999997, -0.0026439, 300, 0, 1, '', 0),
(@OGUID+4 , 500000, 595, 0, 0, 4, 1, 1445.49, 535.129, 33.6929, 5.47695, -0, -0, -0.392289, 0.919842, 300, 0, 1, '', 0),
(@OGUID+5 , 500000, 619, 0, 0, 4, 1, 390.621, -1072.34, 47.3608, 0.590037, -0, -0, -0.290758, -0.956797, 300, 0, 1, '', 0),
(@OGUID+6 , 500000, 668, 0, 0, 4, 1, 5243.7, 1937.54, 707.695, 0.797948, -0, -0, -0.388473, -0.92146, 300, 0, 1, '', 0),
(@OGUID+7 , 500000, 632, 0, 0, 4, 1, 4918.51, 2213.91, 638.734, 0.426733, -0, -0, -0.211751, -0.977324, 300, 0, 1, '', 0),
(@OGUID+8 , 500000, 658, 0, 0, 4, 1, 425.338, 225.955, 528.938, 1.81773, -0, -0, -0.788808, -0.61464, 300, 0, 1, '', 0),
(@OGUID+9 , 500000, 658, 0, 0, 4, 1, 414.704, 207.066, 528.706, 3.33696, -0, -0, -0.995233, 0.0975265, 300, 0, 1, '', 0),
(@OGUID+10, 500000, 658, 0, 0, 4, 1, 434.498, 197.939, 529.921, 4.98289, -0, -0, -0.605304, 0.795995, 300, 0, 1, '', 0),
(@OGUID+11, 500000, 658, 0, 0, 4, 1, 442.356, 213.836, 528.71, 0.167615, -0, -0, -0.0837095, -0.99649, 300, 0, 1, '', 0),
(@OGUID+12, 500000, 650, 0, 0, 4, 1, 798.695, 618.001, 412.393, 3.17178, -0, -0, -0.999886, 0.015092, 300, 0, 1, '', 0),
(@OGUID+13, 500000, 608, 0, 0, 4, 1, 1822.67, 803.851, 44.364, 0.00300376, -0, -0, -0.00150809, -0.999999, 300, 0, 1, '', 0),
(@OGUID+14, 500000, 599, 0, 0, 4, 1, 1153.23, 796.882, 195.938, 4.7199, -0, -0, -0.704445, 0.709759, 300, 0, 1, '', 0),
(@OGUID+15, 500000, 602, 0, 0, 4, 1, 1331.65, 225.133, 52.9891, 4.75347, -0, -0, -0.692433, 0.721483, 300, 0, 1, '', 0),
(@OGUID+16, 500000, 600, 0, 0, 4, 1, -519.888, -527.993, 11.0113, 3.94699, -0, -0, -0.920007, 0.391902, 300, 0, 1, '', 0),
(@OGUID+17, 500000, 601, 0, 0, 4, 1, 452, 764.675, 825.978, 5.79728, -0, -0, -0.240572, 0.970631, 300, 0, 1, '', 0),
(@OGUID+18, 500000, 604, 0, 0, 4, 1, 1869.46, 853.674, 176.666, 3.13391, -0, -0, -0.999993, -0.00384373, 300, 0, 1, '', 0);

SET @GUID := 1980000;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID + 15;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(@GUID+0 , 200000, 576, 0, 0, 4, 1, 0, 0, 163.299, -5.34674, -16.6367, 0.0095644, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+1 , 200000, 575, 0, 0, 4, 1, 0, 0, 557.431, -327.453, 110.138, 3.07068, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+2 , 200000, 574, 0, 0, 4, 1, 0, 0, 165.722, -81.9846, 12.5517, 0.376519, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+3 , 200000, 604, 0, 0, 4, 1, 0, 0, 1882.36, 631.306, 176.696, 3.16772, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+4 , 200000, 595, 0, 0, 4, 1, 0, 0, 1440.77, 539.75, 34.0894, 5.50836, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+5 , 200000, 619, 0, 0, 4, 1, 0, 0, 385.553, -1074.94, 47.3605, 0.590037, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+6 , 200000, 668, 0, 0, 4, 1, 0, 0, 5240.69, 1934.45, 707.695, 0.797948, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+7 , 200000, 632, 0, 0, 4, 1, 0, 0, 4913.39, 2210.67, 638.733, 0.502653, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+8 , 200000, 658, 0, 0, 4, 1, 0, 0, 436.755, 214.932, 528.708, 0.207142, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+9 , 200000, 650, 0, 0, 4, 1, 0, 0, 804.449, 618.145, 412.393, 3.15084, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+10, 200000, 608, 0, 0, 4, 1, 0, 0, 1818.48, 803.839, 44.364, 0.00300376, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+11, 200000, 599, 0, 0, 4, 1, 0, 0, 1153.54, 801.97, 195.938, 4.69634, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+12, 200000, 602, 0, 0, 4, 1, 0, 0, 1331.63, 232.309, 52.5047, 4.74169, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+13, 200000, 600, 0, 0, 4, 1, 0, 0, -516.795, -524.353, 11.0112, 4.01898, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+14, 200000, 601, 0, 0, 4, 1, 0, 0, 445.007, 770.098, 827.322, 5.73968, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0),
(@GUID+15, 200000, 604, 0, 0, 4, 1, 0, 0, 1876.44, 853.62, 176.696, 3.13391, 300, 0, 0, 6451, 0, 0, 0, 0, 0, '', 0);

-- ------------
-- NEXUS
DELETE FROM `access_requirement` WHERE `mapId`=576 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(576, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'The Nexus (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (576) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(576, 2, 1, 'The Nexus (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 576;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 576;

-- UTGARD PINNACLE
DELETE FROM `access_requirement` WHERE `mapId`=575 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(575, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Utgard Pinnacle (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (575) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(575, 2, 1, 'Utgard Pinnacle (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 575;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 575;


-- UTGARD KEEP
DELETE FROM `access_requirement` WHERE `mapId`=574 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(574, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Utgard Keep (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (574) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(574, 2, 1, 'Utgard Keep (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 574;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 574;


-- GUNDRAK
DELETE FROM `access_requirement` WHERE `mapId`=604 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(604, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Gundrak (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (604) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(604, 2, 1, 'Gundrak (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 604;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 604;

-- STRATHOLME
DELETE FROM `access_requirement` WHERE `mapId`=595 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(595, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Stratholme (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (595) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(595, 2, 1, 'Stratholme (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 595;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 595;

-- HALLS OF STONE
DELETE FROM `access_requirement` WHERE `mapId`=599 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(599, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Halls of Stone (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (599) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(599, 2, 1, 'Halls of Stone (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 599;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 599;

-- DRAK THARON KEEP
DELETE FROM `access_requirement` WHERE `mapId`=600 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(600, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Drak Tharon Keep (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (600) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(600, 2, 1, 'Drak Tharon Keep (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 600;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 600;


-- AZJOL NERUB
DELETE FROM `access_requirement` WHERE `mapId`=601 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(601, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Azjol Nerub (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (601) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(601, 2, 1, 'Azjol Nerub (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 601;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 601;

-- HALLS OF LIGHTNING
DELETE FROM `access_requirement` WHERE `mapId`=602 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(602, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Halls of Lightning (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (602) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(602, 2, 1, 'Halls of Lightning (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 602;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 602;

-- AHN KAHET
DELETE FROM `access_requirement` WHERE `mapId`=619 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(619, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Ahn Kahet (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (619) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(619, 2, 1, 'Ahn Kahet (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 619;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 619;

-- FORGE OF SOULS
DELETE FROM `access_requirement` WHERE `mapId`=632 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(632, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Forge of Souls (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (632) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(632, 2, 1, 'Forge of Souls (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 632;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 632;


-- VIOLET HOLD
DELETE FROM `access_requirement` WHERE `mapId`=608 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(608, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Violet Hold (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (608) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(608, 2, 1, 'Violet Hold (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 608;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 608;

-- TRIAL OF THE CHAMPION
DELETE FROM `access_requirement` WHERE `mapId`=650 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(650, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Trial of The Champion (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (650) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(650, 2, 1, 'Trial of The Champion (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 650;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 650;

-- PIT OF SARON
DELETE FROM `access_requirement` WHERE `mapId`=658 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(658, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Pit Of Saron (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (658) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(658, 2, 1, 'Pit Of Saron (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 658;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 658;

-- HALLS OF REFLECTION
DELETE FROM `access_requirement` WHERE `mapId`=668 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(668, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'Halls of Reflection (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId` IN (668) AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(668, 2, 1, 'Halls of Reflection (Mythic Plus)');

UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 668;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 668;

-- QUESTS ------------------------------
SET @QUEST_START := 300000;
SET @QUEST_END := 300100;

-- Nexus
SET @TIME_G := 1680; -- 35 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

DELETE FROM `quest_template` WHERE `ID` BETWEEN @QUEST_START AND @QUEST_END;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+00, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Nexus: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+01, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Nexus: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+02, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Nexus: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Violet Hold
SET @TIME_G := 840; -- 15 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+03, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Violet Hold: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+04, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Violet Hold: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+05, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Violet Hold: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Gundrak
SET @TIME_G := 600; -- 15 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+06, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Gundrak: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+07, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Gundrak: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+08, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Gundrak: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Halls of Reflection
SET @TIME_G := 1200; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+09, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Halls of Reflection: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+10, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Halls of Reflection: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+11, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Halls of Reflection: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Pit of Saron
SET @TIME_G := 1500; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+12, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Pit of Saron: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+13, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Pit of Saron: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+14, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Pit of Saron: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Trial of Champion
SET @TIME_G := 900; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+15, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Trial of Champion: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+16, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Trial of Champion: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+17, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Trial of Champion: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Forge of Souls
SET @TIME_G := 660; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+18, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Forge of Souls: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+19, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Forge of Souls: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+20, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Forge of Souls: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Ahn Kahet
SET @TIME_G := 840; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+42, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic AhnKahet: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+43, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic AhnKahet: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+44, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic AhnKahet: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Halls of Lightning
SET @TIME_G := 1200; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+21, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Halls of Lightning: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Halls of Lightning: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+23, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Halls of Lightning: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Azjol Nerub
SET @TIME_G := 960; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+24, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Azjol Nerub: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+25, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Azjol Nerub: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+26, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Azjol Nerub: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Drak Tharon
SET @TIME_G := 720; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+27, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Drak Tharon: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+28, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Drak Tharon: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+29, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Drak Tharon: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Halls of Stone
SET @TIME_G := 2100; -- 35 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+30, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Halls of Stone: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+31, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Halls of Stone: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+32, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Halls of Stone: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Stratholme
SET @TIME_G := 1200; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+33, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Stratholme: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+34, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Stratholme: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+35, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Stratholme: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Utgard Pinnacle
SET @TIME_G := 1020; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+36, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Utgard Pinnacle: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+37, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Utgard Pinnacle: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+38, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Utgard Pinnacle: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

-- Utgard Keep
SET @TIME_G := 1080; -- 20 Minutes
SET @TIME_S := @TIME_G* 1.3 - @TIME_G;
SET @TIME_B := (@TIME_G* 1.6 - @TIME_G) - @TIME_S;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardBonusMoney`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES 
(@QUEST_START+39, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_G, 0, 'Mythic Utgard Pinnacle: Gold Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+40, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_S, 0, 'Mythic Utgard Pinnacle: Silver Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
(@QUEST_START+41, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @TIME_B, 0, 'Mythic Utgard Pinnacle: Bronze Time', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

UPDATE `quest_template` SET `QuestSortID` = -284, `RequiredNpcOrGoCount1`=1, `Flags`=262144, `QuestLevel`=80, `MinLevel`=80, `LogDescription`='Clear this dungeon before this timer!', `AreaDescription`='Clear this dungeon before this timer!', `ObjectiveText1`='Clear this dungeon before this timer!', `RequiredNpcOrGo1`=1 WHERE `ID` BETWEEN @QUEST_START AND @QUEST_END;

DELETE FROM `acore_string` WHERE `entry`=11187;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES 
(11187, '%s');

DELETE FROM `mythic_dungeon_times` WHERE `mapId` IN (
576,
575,
574,
604,
595,
599,
600,
601,
602,
619,
632,
608,
650,
658,
668);

INSERT INTO `mythic_dungeon_times` (`mapId`, `bestTime`, `comment`, `keystone_entry`) VALUES 
(576, 1680000, 'The Nexus - 28 Minutes', 6208),
(575, 1020000, 'Utgard Pinnacle - 17 Minutes', 31645),
(574, 1080000, 'Utgard Keep - 18 Minutes', 33456),
(604, 600000, 'Gundrak - 10 Minutes', 16308),
(595, 1200000, 'Stratholme - 20 Minutes', 23956),
(599, 2100000, 'Halls of Stone - 35 Minutes', 23674),
(600, 720000, 'Drak Tharon Keep - 12 Minutes', 6209),
(601, 960000, 'Azjol Nerub - 16 Minutes', 6210),
(602, 1200000, 'Halls of Lightning - 20 Minutes', 22486),
(619, 840000, 'Ahn Kahet - 14 Minutes', 36763),
(632, 660000, 'Forge of Souls - 11 Minutes', 11100),
(608, 840000, 'Violet Hold - 14 Minutes', 24010),
(650, 900000, 'Trial of The Champion - 15 Minutes', 11085),
(658, 1500000, 'Pit Of Saron - 25 Minutes', 11115),
(668, 1200000, 'Halls of Reflection - 20 Minutes', 12143);
