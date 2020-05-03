ALTER TABLE `mythic_finish_groups`
	ADD COLUMN `affixesMask` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `time`;
