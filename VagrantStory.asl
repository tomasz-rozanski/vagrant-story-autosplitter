/*

   Scriptable Auto Splitter for Vagrant Story (PSOne) 

   Supported SKUs: SLUS-01040 (NTSC-U)

   Supported emulators:
   - Duckstation
   - Mednafen
   - PCSX_Redux
   - Retroarch
   - Xebra
   - ePSXe
   - pSX

   Supported actions:
   - splits when BossHP == 0 (including some mini-bosses)
   - starts the timer when the game starts (New Game, New Game+)
   - resets the timer when you get back to the title screen 
   - handles multi-enemy fights in any order (Duane, Grissom, Tieger and Neesa)

   Requirements:
   - LiveSplit (https://github.com/LiveSplit/LiveSplit)
   - emu-help (https://github.com/Jujstme/emu-help)

 */

state("LiveSplit") {}

startup {
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS1");

    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
            {
            emu.Make<uint>("IGT", 0x80061074);
            emu.Make<byte>("IGTCenti", 0x80061074);
            emu.Make<byte>("IGTSec", 0x80061075);
            emu.Make<byte>("IGTMin", 0x80061076);
            emu.Make<byte>("IGTHour", 0x80061077);

            emu.Make<uint>("Location", 0x800f1ab0);
            emu.Make<byte>("Area", 0x800f1ab0);
            emu.Make<byte>("Room", 0x800f1ab1);
            emu.Make<byte>("Teleport", 0x800f1a48);

            emu.Make<uint>("GameStatus", 0x800f196c);
            emu.Make<ushort>("ExeType", 0x80068800);
            emu.Make<ushort>("MenuType", 0x80102800);

            emu.Make<uint>("ActorsListPtr", 0x800f1928);
            emu.Make<uint>("FirstEnemyPtr", 0x8011f9f0);

            emu.Make<ushort>("PlayerHP", 0x8011fa58);

            // Bosses HP
            emu.Make<ushort>("MinotaurHP", 0x80180bd8);
            emu.Make<ushort>("DullahanHP", 0x80181338);
            emu.Make<ushort>("Lizardman1HP", 0x80189f28);
            emu.Make<ushort>("Lizardman2HP", 0x8017e658);
            emu.Make<ushort>("GolemHP", 0x8017da18);
            emu.Make<ushort>("DragonHP", 0x8017e878);
            emu.Make<ushort>("DuaneHP", 0x8018a0e8);
            emu.Make<ushort>("BejartHP", 0x801a0d58);
            emu.Make<ushort>("SarjikHP", 0x80195888);
            emu.Make<ushort>("WyvernHP", 0x801810f8);
            emu.Make<ushort>("FireElementalHP", 0x80181cc8);
            emu.Make<ushort>("OgreHP", 0x80181368);
            emu.Make<ushort>("GiantCrabHP", 0x801875d8);
            emu.Make<ushort>("EarthDragonHP", 0x801800b8);
            emu.Make<ushort>("GrissomHP", 0x80181528);
            emu.Make<ushort>("DarkCrusaderHP", 0x8018d3a8);
            emu.Make<ushort>("SydneyHP", 0x8019bf88);
            emu.Make<ushort>("RosencrantzHP", 0x8017f9a8);
            emu.Make<ushort>("DarkElementalHP", 0x80187548);
            emu.Make<ushort>("SkyDragonHP", 0x80185dd8);
            emu.Make<ushort>("LichHP", 0x80182a08);
            emu.Make<ushort>("NightstalkerHP", 0x801829e8);
            emu.Make<ushort>("TiegerHP", 0x801913b8);
            emu.Make<ushort>("NeesaHP", 0x80182b48);
            emu.Make<ushort>("WaterElementalHP", 0x80183e28);
            emu.Make<ushort>("OgreLordHP", 0x80183f78);
            emu.Make<ushort>("SnowDragonHP", 0x80183f98);
            emu.Make<ushort>("KaliHP", 0x8017e8a8);
            emu.Make<ushort>("MaridHP", 0x8017daa8);
            emu.Make<ushort>("IfritHP", 0x8017ef28);
            emu.Make<ushort>("DjinnHP", 0x8017ce38);
            emu.Make<ushort>("FlameDragonHP", 0x801815e8);
            emu.Make<ushort>("ArchDragonHP", 0x80181128);
            emu.Make<ushort>("DaoHP", 0x8017cfb8);
            emu.Make<ushort>("NightmareHP", 0x8017e878);
            emu.Make<ushort>("GuildensternP1HP", 0x80180b18);
            emu.Make<ushort>("GuildensternP2HP", 0x8017cd08);

            // Bosses struct pointers
            emu.Make<uint>("MinotaurPtr", 0x80180b70);
            emu.Make<uint>("DullahanPtr", 0x801812d0);
            emu.Make<uint>("Lizardman1Ptr", 0x80189ec0);
            emu.Make<uint>("Lizardman2Ptr", 0x8017e5f0);
            emu.Make<uint>("GolemPtr", 0x8017d9b0);
            emu.Make<uint>("DragonPtr", 0x8017e810);
            emu.Make<uint>("DuanePtr", 0x8018a080);
            emu.Make<uint>("BejartPtr", 0x801a0cf0);  
            emu.Make<uint>("SarjikPtr", 0x80195820); 
            emu.Make<uint>("WyvernPtr", 0x80181090);
            emu.Make<uint>("FireElementalPtr", 0x80181c60);
            emu.Make<uint>("OgrePtr", 0x80181300);
            emu.Make<uint>("GiantCrabPtr", 0x80187570);
            emu.Make<uint>("EarthDragonPtr", 0x80180050);
            emu.Make<uint>("GrissomPtr", 0x801814c0);
            emu.Make<uint>("DarkCrusaderPtr", 0x8018d340);
            emu.Make<uint>("SydneyPtr", 0x8019bf20);
            emu.Make<uint>("RosencrantzPtr", 0x8017f940);
            emu.Make<uint>("DarkElementalPtr", 0x801874e0);
            emu.Make<uint>("SkyDragonPtr", 0x80185d70);
            emu.Make<uint>("LichPtr", 0x801829a0);
            emu.Make<uint>("NightstalkerPtr", 0x80182980);
            emu.Make<uint>("TiegerPtr", 0x80191350);
            emu.Make<uint>("NeesaPtr", 0x80182ae0);
            emu.Make<uint>("WaterElementalPtr", 0x80183dc0);
            emu.Make<uint>("OgreLordPtr", 0x80183f10);
            emu.Make<uint>("SnowDragonPtr", 0x80183f30);
            emu.Make<uint>("KaliPtr", 0x8017e840);
            emu.Make<uint>("MaridPtr", 0x8017da40);
            emu.Make<uint>("IfritPtr", 0x8017eec0);
            emu.Make<uint>("DjinnPtr", 0x8017cdd0);
            emu.Make<uint>("FlameDragonPtr", 0x80181580);
            emu.Make<uint>("ArchDragonPtr", 0x801810c0);
            emu.Make<uint>("DaoPtr", 0x8017cf50);
            emu.Make<uint>("NightmarePtr", 0x8017e810);
            emu.Make<uint>("GuildensternP1Ptr", 0x80180ab0);
            emu.Make<uint>("GuildensternP2Ptr", 0x8017cca0);

            return true;
            });
}


isLoading {
    if (old.IGT == current.IGT) return true;

    return false;
}

start {
    if (old.ExeType == vars.EXE_TYPE_TITLE_SCREEN && current.ExeType == vars.EXE_TYPE_MAIN_GAME) return true;

    return false;
}

reset {
    if (current.ExeType == vars.EXE_TYPE_TITLE_SCREEN) return true;
}

init {
    vars.GAME_STATUS_NORMAL = 0x01;
    vars.GAME_STATUS_BATTLE = 0x02;
    vars.GAME_STATUS_CUTSCENE = 0x03;
    vars.GAME_STATUS_MENU_SCREEN = 0x05;
    vars.GAME_STATUS_QUICK_MENU = 0x06;
    vars.GAME_STATUS_FP_VIEW = 0x07;
    vars.GAME_STATUS_ACTIVATE_PANEL = 0x08;
    vars.GAME_STATUS_OPEN_CONTAINER = 0x09;
    vars.GAME_STATUS_DRAW_WEAPON = 0x0a;
    vars.GAME_STATUS_USE_OPEN_DOOR = 0x0b;
    vars.GAME_STATUS_END_OF_TURN = 0x0c;

    vars.MENU_TYPE_BONUS_ROULETTE = 0xfffa;
    vars.MENU_TYPE_ITEM_DROP_LIST = 0x2058;

    vars.EXE_TYPE_TITLE_SCREEN = 0x7562;
    vars.EXE_TYPE_MAIN_GAME = 0xc684;

    vars.Lizardman1IsDead = false;
    vars.Lizardman2IsDead = false;

    vars.BejartIsDead = false;
    vars.SarjikIsDead = false;
    vars.DuaneIsDead = false;

    vars.GrissomIsDead = false;
    vars.DarkCrusaderIsDead = false;

    vars.TiegerDataPtr = 0x80191350;
}

split {

    var cur_segname = timer.CurrentSplit.Name;

    if (cur_segname == "Minotaur") {
        if (current.Area == 12 && current.Room == 0) 
            return (old.MinotaurHP > 0 && current.MinotaurHP == 0);
    } else if (cur_segname == "Dullahan") {
        if (current.Area == 11 && current.Room == 0)
            return (old.DullahanHP > 0 && current.DullahanHP == 0);
    } else if (cur_segname == "Lizardmen") {
        if (current.Area == 14 && current.Room == 0) {
            if (old.Lizardman1HP > 0 && current.Lizardman1HP == 0) vars.Lizardman1IsDead = true;
            if (old.Lizardman2HP > 0 && current.Lizardman2HP == 0) vars.Lizardman2IsDead = true;

            return (vars.Lizardman1IsDead && vars.Lizardman2IsDead);
        }
    } else if (cur_segname == "Golem") {
        if (current.Area == 16 && current.Room == 0)
            return (old.GolemHP > 0 && current.GolemHP == 0);
    } else if (cur_segname == "Dragon") {
        if (current.Area == 17 && current.Room == 0)
            return (old.DragonHP > 0 && current.DragonHP == 0);
    } else if (cur_segname == "Duane") {
        if (current.Area == 32 && current.Room == 3 && current.GameStatus == vars.GAME_STATUS_BATTLE) {
            if (old.BejartHP > 0 && current.BejartHP == 0) vars.BejartIsDead = true;
            if (old.SarjikHP > 0 && current.SarjikHP == 0) vars.SarjikIsDead = true;
            if (old.DuaneHP > 0 && current.DuaneHP == 0) vars.DuaneIsDead = true;

            if (vars.BejartIsDead && vars.SarjikIsDead && vars.DuaneIsDead) {
                // Uncomment for testing
                // vars.BejartIsDead = false; 
                // vars.SarjikIsDead = false;
                // vars.DuaneIsDead = false;

                return true;
            }
        }
    } else if (cur_segname == "Wyvern") {
        if (current.Area == 50 && current.Room == 6)
            return (old.WyvernHP > 0 && current.WyvernHP == 0);
    } else if (cur_segname == "Fire Elemental") {
        if (current.Area == 50 && current.Room == 17)
            return (old.FireElementalHP > 0 && current.FireElementalHP == 0);
    } else if (cur_segname == "Ogre") {
        if (current.Area == 50 && current.Room == 22)
            return (old.OgreHP > 0 && current.OgreHP == 0);
    } else if (cur_segname == "Giant Crab") {
        if (current.Area == 48 && current.Room == 3)
            return (old.GiantCrabHP > 0 && current.GiantCrabHP == 0);
    } else if (cur_segname == "Earth Dragon") {
        if (current.Area == 40 && current.Room == 22)
            return (old.EarthDragonHP > 0 && current.EarthDragonHP == 0);
    } else if (cur_segname == "Grissom") {
        if (current.Area == 40 && current.Room == 24) {
            if (old.GrissomHP > 0 && current.GrissomHP == 0) vars.GrissomIsDead = true;
            if (old.DarkCrusaderHP > 0 && current.DarkCrusaderHP == 0) vars.DarkCrusaderIsDead = true;

            if (vars.GrissomIsDead && vars.DarkCrusaderIsDead) {
                // Uncomment for testing
                // vars.GrissomIsDead = false; 
                // vars.DarkCrusaderIsDead = false;

                return true;
            }
        }
    } else if (cur_segname == "Rosencrantz") {
        if (current.Area == 29 && current.Room == 0)
            return (old.RosencrantzHP > 0 && current.RosencrantzHP == 0);
    } else if (cur_segname == "Dark Elemental") {
        if (current.Area == 48 && current.Room == 15)
            return (old.DarkElementalHP > 0 && current.DarkElementalHP == 0);
    } else if (cur_segname == "Sky Dragon") {
        if (current.Area == 51 && current.Room == 6)
            return (old.SkyDragonHP > 0 && current.SkyDragonHP == 0);
    } else if (cur_segname == "Lich") {
        if (current.Area == 49 && current.Room == 2)
            return (old.LichHP > 0 && current.LichHP == 0);
    } else if (cur_segname == "Nightstalker") {
        if (current.Area == 49 && current.Room == 5)
            return (old.NightstalkerHP > 0 && current.NightstalkerHP == 0);
    } else if (cur_segname == "Neesa and Tieger") {
        if (current.Area == 49 && current.Room == 10 && current.FirstEnemyPtr == vars.TiegerDataPtr) {
            return ((current.TiegerHP == 0 && current.NeesaHP > 0) ||
                    (current.TiegerHP > 0 && current.NeesaHP == 0));
        }
    } else if (cur_segname == "Water Elemental") {
        if (current.Area == 53 && current.Room == 1)
            return (old.WaterElementalHP > 0 && current.WaterElementalHP == 0);
    } else if (cur_segname == "Ogre Lord") {
        if (current.Area == 53 && current.Room == 23)
            return (old.OgreLordHP > 0 && current.OgreLordHP == 0);
    } else if (cur_segname == "Snow Dragon") {
        if (current.Area == 53 && current.Room == 29)
            return (old.SnowDragonHP > 0 && current.SnowDragonHP == 0);
    } else if (cur_segname == "Kali") {
        if (current.Area == 31 && current.Room == 0)
            return (old.KaliHP > 0 && current.KaliHP == 0);
    } else if (cur_segname == "Marid") {
        if (current.Area == 22 && current.Room == 6)
            return (old.MaridHP > 0 && current.MaridHP == 0);
    } else if (cur_segname == "Ifrit") {
        if(current.Area == 22 && current.Room == 4)
            return (old.IfritHP > 0 && current.IfritHP == 0);
    } else if (cur_segname == "Djinn") {
        if (current.Area == 24 && current.Room == 0)
            return (old.DjinnHP > 0 && current.DjinnHP == 0);
    } else if (cur_segname == "Flame Dragon") {
        if (current.Area == 24 && current.Room == 11)
            return (old.FlameDragonHP > 0 && current.FlameDragonHP == 0);
    } else if (cur_segname == "Arch Dragon") {
        if (current.Area == 24 && current.Room == 4)
            return (old.ArchDragonHP > 0 && current.ArchDragonHP == 0);
    } else if (cur_segname == "Dao") {
        if (current.Area == 24 && current.Room == 15)
            return (old.DaoHP > 0 && current.DaoHP == 0);
    } else if (cur_segname == "Nightmare") {
        if (current.Area == 25 && current.Room == 1)
            return (old.NightmareHP > 0 && current.NightmareHP == 0);
    } else if (cur_segname == "Guildenstern (Phase 1)") {
        if (current.Area == 27 && current.Room == 0)
            return (old.GuildensternP1HP > 0 && current.GuildensternP1HP == 0);
    } else if (cur_segname == "Guildenstern (Phase 2)") {
        if (current.Area == 27 && current.Room == 1)
            return (old.GuildensternP2HP > 0 && current.GuildensternP2HP == 0);
    }
}
