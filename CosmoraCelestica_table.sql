-- Use the Database
USE CosmoraCelestica;
GO

-- Insert Users with BCrypt hashed passwords ( No need )

-- Insert Games
INSERT INTO Games (title, description, image_url, price, release_date) VALUES
('Cyberpunk 2077', 'A futuristic open-world RPG where you play as V, a mercenary in Night City, a megalopolis obsessed with power, glamour, and body modification. Customize your character, make choices, and explore a cyberpunk dystopia.', 'cyberpunk.jpg', 59.99, '2020-12-10'),
('The Witcher 3', 'An epic fantasy RPG set in a vast open world. As Geralt of Rivia, a monster hunter, you embark on a quest to find your adopted daughter while battling mythical creatures and navigating political intrigue.', 'witcher3.jpg', 39.99, '2015-05-19'),
('Grand Theft Auto V', 'A massive open-world crime game set in Los Santos. Play as three distinct characters as you pull off heists, explore a sprawling city, and engage in high-speed chases and criminal activities.', 'gtav.jpg', 29.99, '2013-09-17'),
('Dark Souls III', 'A dark fantasy action RPG that challenges players with punishing difficulty. Explore a ruined kingdom, face nightmarish creatures, and master strategic combat in a world shrouded in mystery.', 'darksouls3.jpg', 49.99, '2016-03-24'),
('Elden Ring', 'A vast open-world action RPG where you journey through the Lands Between, seeking to become the Elden Lord. Battle formidable bosses, explore dungeons, and uncover secrets in a breathtaking dark fantasy setting.', 'eldenring.jpg', 59.99, '2022-02-25'),
('Super Mario Odyssey', 'A whimsical 3D platformer where Mario embarks on a globe-trotting adventure to save Princess Peach. Use Cappy to possess enemies, solve puzzles, and explore vibrant kingdoms.', 'supermarioodyssey.jpg', 49.99, '2017-10-27'),
('The Legend of Zelda: Breath of the Wild', 'An open-world action-adventure game set in Hyrule. Play as Link, awaken after a century-long slumber, and embark on a quest to defeat Calamity Ganon while solving puzzles and uncovering secrets.', 'zeldabotw.jpg', 59.99, '2017-03-03'),
('DOOM Eternal', 'A fast-paced first-person shooter where you become the Doom Slayer, battling demonic hordes across dimensions. Use brutal weapons, parkour mechanics, and adrenaline-fueled combat to save humanity.', 'doometernal.jpg', 49.99, '2020-03-20'),
('Call of Duty: Modern Warfare', 'A cinematic military FPS that reboots the classic Modern Warfare series. Engage in tactical combat with an elite task force, experience intense multiplayer battles, and dive into a gripping campaign.', 'codmw.jpg', 59.99, '2019-10-25'),
('Resident Evil Village', 'A survival horror experience where you explore a sinister village haunted by supernatural horrors. Play as Ethan Winters and fight to uncover the dark secrets behind a terrifying new threat.', 'residentevilvillage.jpg', 59.99, '2021-05-07'),
('Red Dead Redemption 2', 'A vast open-world western adventure where you play as Arthur Morgan, an outlaw struggling with loyalty and survival in the dying days of the Wild West. Hunt, rob, and explore in a richly detailed world.', 'reddeadredemption2.jpg', 59.99, '2018-10-26'),
('Horizon Forbidden West', 'A breathtaking open-world RPG where you play as Aloy, a hunter in a world overrun by mechanical beasts. Unravel mysteries, battle powerful enemies, and explore a post-apocalyptic landscape.', 'horizonfw.jpg', 69.99, '2022-02-18'),
('God of War Ragnarok', 'An epic action-adventure set in Norse mythology. Play as Kratos and his son Atreus as they journey through realms, face gods and monsters, and uncover their intertwined destinies.', 'gowragnarok.jpg', 69.99, '2022-11-09'),
('Halo Infinite', 'A sci-fi first-person shooter where you play as Master Chief in an expansive open-world campaign. Battle the Banished, wield powerful weapons, and uncover the mysteries of Zeta Halo.', 'haloinfinite.jpg', 59.99, '2021-12-08'),
('Forza Horizon 5', 'An open-world racing game set in a dynamic Mexico. Drive hundreds of cars across breathtaking landscapes, take on challenges, and experience high-speed action in an evolving world.', 'forzahorizon5.jpg', 59.99, '2021-11-09'),
('Street Fighter 6', 'A legendary fighting game series returns with new mechanics, dynamic combat, and a diverse roster of characters. Train, fight, and master combos in competitive battles.', 'sf6.jpg', 59.99, '2023-06-02'),
('The Last of Us Part II', 'A gripping survival action-adventure where you play as Ellie, seeking revenge in a post-apocalyptic world. Experience brutal combat, emotional storytelling, and immersive stealth mechanics.', 'thelastofus2.jpg', 59.99, '2020-06-19'),
('Monster Hunter World', 'A cooperative fantasy action RPG where you hunt down massive monsters in a living, breathing ecosystem. Craft gear, track creatures, and battle alongside allies in thrilling encounters.', 'monsterhunterworld.jpg', 49.99, '2018-01-26'),
('Starfield', 'An open-world space RPG where you embark on an interstellar journey. Customize your ship, explore distant planets, and uncover the mysteries of the galaxy in an immersive sci-fi experience.', 'starfield.jpg', 69.99, '2023-09-06'),
('Baldur’s Gate 3', 'A deep fantasy RPG based on Dungeons & Dragons. Gather a party, engage in tactical turn-based combat, and shape the fate of the Forgotten Realms through your choices and actions.', 'baldurgate3.jpg', 69.99, '2023-08-03'),
('Dead by Daylight', 'A heart-pounding asymmetric multiplayer horror game where four survivors must evade a relentless killer in eerie environments. Work together to repair generators, unlock the exit, and escape—while the killer hunts them down using terrifying abilities.', 'deadbydaylight.jpg', 19.99, '2016-06-14'),
('Five Nights at Freddy’s: Security Breach', 'Step into the shoes of Gregory, a young boy trapped overnight in the massive Freddy Fazbear’s Mega Pizzaplex. Use security cameras, sneak past creepy animatronics, and uncover the horrifying secrets hidden in the depths of the facility.', 'fnafsecuritybreach.jpg', 39.99, '2021-12-16'),
('Phasmophobia', 'A spine-chilling co-op ghost-hunting simulation where players use real paranormal tools like EMF readers and spirit boxes to gather evidence of hauntings. Every mission brings unpredictable encounters with ghosts, creating a dynamic and terrifying experience.', 'phasmophobia.jpg', 14.99, '2020-09-18'),
('The Forest', 'A survival horror adventure set in a dense, mysterious forest where you must gather resources, craft tools, and build shelter—all while evading a hostile tribe of cannibalistic mutants lurking in the shadows.', 'theforest.jpg', 19.99, '2018-04-30'),
('Amnesia: The Bunker', 'A psychological horror game set in a desolate World War I bunker. Trapped underground with a monstrous presence hunting you, you must manage scarce resources, navigate the darkness, and uncover the sinister truth.', 'amnesiabunker.jpg', 24.99, '2023-06-06'),
('The Sims 4', 'Create and control virtual lives in this highly detailed life simulation. Design homes, build relationships, pursue careers, and shape your Sims’ destinies in a sandbox world filled with endless possibilities.', 'thesims4.jpg', 39.99, '2014-09-02'),
('Cities: Skylines II', 'A highly immersive city-building simulation where you can design and manage a bustling metropolis. Plan road networks, handle infrastructure, balance budgets, and respond to citizen needs in a realistic urban environment.', 'citiesskylines2.jpg', 49.99, '2023-10-24'),
('Farming Simulator 22', 'Experience the life of a modern farmer with authentic machinery, crops, and livestock. Manage agricultural operations, cultivate fields, and expand your business in a highly realistic farming simulation.', 'farmingsim22.jpg', 34.99, '2021-11-22'),
('Euro Truck Simulator 2', 'Drive across Europe in a realistic truck simulator where you manage your own logistics company. Deliver cargo, upgrade your fleet, and experience breathtaking landscapes in a meticulously crafted open world.', 'eurotrucksim2.jpg', 19.99, '2012-10-19'),
('PowerWash Simulator', 'A surprisingly satisfying simulation where you wield a power washer to clean vehicles, buildings, and urban environments. Enjoy the relaxing, stress-free gameplay while watching grime vanish with every spray.', 'powerwashsim.jpg', 24.99, '2022-07-14'),
('Civilization VI', 'Lead a civilization from the dawn of time to the modern era in this turn-based strategy game. Wage war, build wonders, expand borders, and compete against world leaders to leave a lasting legacy.', 'civ6.jpg', 59.99, '2016-10-21'),
('Total War: Warhammer III', 'A grand strategy game blending turn-based empire management with epic real-time battles set in the Warhammer fantasy universe. Lead legendary heroes and massive armies to conquer the chaos-infested realms.', 'totalwarwarhammer3.jpg', 59.99, '2022-02-17'),
('Age of Empires IV', 'A historically inspired real-time strategy game where you command civilizations from different eras. Build mighty empires, wage strategic battles, and shape history through innovative warfare and diplomacy.', 'aoe4.jpg', 59.99, '2021-10-28'),
('XCOM 2', 'A tactical squad-based strategy game where you command a resistance force battling alien invaders. Upgrade your base, research new technologies, and engage in intense turn-based combat to reclaim Earth.', 'xcom2.jpg', 39.99, '2016-02-05'),
('Crusader Kings III', 'A deep medieval grand strategy game where you control a noble dynasty, form alliances, wage war, and navigate political intrigue to ensure your lineage thrives through generations.', 'ck3.jpg', 49.99, '2020-09-01'),
('FIFA 24', 'The ultimate football simulation experience featuring real teams, players, and leagues. Master precision dribbling, tactical gameplay, and thrilling matches across career and online modes.', 'fifa24.jpg', 69.99, '2023-09-29'),
('NBA 2K24', 'A hyper-realistic basketball simulation with advanced physics, player animations, and immersive career modes. Compete in online tournaments or build your dream team in MyTeam mode.', 'nba2k24.jpg', 69.99, '2023-09-08'),
('Madden NFL 24', 'Dominate the gridiron with cutting-edge AI and realistic player movements. Experience the latest improvements in franchise mode, ultimate team, and dynamic gameplay in this American football simulation.', 'maddennfl24.jpg', 69.99, '2023-08-18'),
('Tony Hawk’s Pro Skater 1+2', 'A faithful remake of the legendary skateboarding games featuring stunning graphics, iconic tricks, and an energetic soundtrack. Master flips, grinds, and combos across legendary skate parks.', 'tonyhawk12.jpg', 49.99, '2020-09-04'),
('WWE 2K24', 'Step into the ring with WWE superstars in this realistic wrestling simulation. Customize fighters, create rivalries, and experience dramatic storytelling in the most immersive WWE game yet.', 'wwe2k24.jpg', 59.99, '2024-03-08'),
('Mortal Kombat 11', 'The legendary fighting franchise returns with brutal fatalities, cinematic story mode, and deep character customization. Battle opponents in intense 1v1 combat across dynamic arenas.', 'mk11.jpg', 49.99, '2019-04-23'),
('Tekken 8', 'The latest installment in the Tekken series, featuring a deep combat system, new fighters, and breathtaking visuals. Engage in thrilling 3D battles with a refined combo system.', 'tekken8.jpg', 59.99, '2024-01-26'),
('Guilty Gear Strive', 'A visually stunning anime-style fighting game known for its high-speed combat, flashy combos, and dynamic characters. Compete in ranked matches or dive into an engaging story mode.', 'ggstrive.jpg', 39.99, '2021-06-11'),
('Dragon Ball FighterZ', 'An electrifying 2D fighting game with fast-paced battles, stunning visuals, and legendary Dragon Ball characters. Chain powerful attacks to dominate opponents in online or offline matches.', 'dbfz.jpg', 39.99, '2018-01-26'),
('Super Smash Bros. Ultimate', 'The ultimate crossover fighting game featuring iconic Nintendo and third-party characters. Battle in fast-paced, platform-based combat across diverse and creative stages.', 'ssbu.jpg', 59.99, '2018-12-07'),
('Gran Turismo 7', 'A cutting-edge racing simulator with breathtaking realism, an extensive car roster, and meticulously recreated tracks. Experience precision driving, deep customization, and thrilling races.', 'granturismo7.jpg', 69.99, '2022-03-04'),
('Need for Speed: Unbound', 'A high-speed street racing experience blending realistic driving mechanics with stylish visual effects. Customize cars, evade cops, and race for glory in an urban open world.', 'nfsunbound.jpg', 59.99, '2022-12-02'),
('F1 23', 'The most immersive Formula 1 racing game, featuring updated teams, realistic physics, and a gripping career mode. Compete in high-stakes circuits with precision and strategy.', 'f123.jpg', 69.99, '2023-06-16'),
('MotoGP 23', 'The official MotoGP racing simulation, offering intense motorcycle races, authentic circuits, and a dynamic career mode where you rise from rookie to champion.', 'motogp23.jpg', 49.99, '2023-06-08'),
('Wreckfest', 'A chaotic racing game blending high-speed action with intense vehicular destruction. Smash opponents, upgrade cars, and experience thrilling derby-style gameplay.', 'wreckfest.jpg', 39.99, '2018-06-14'),
('Beat Saber', 'An immersive VR rhythm game where players slash incoming beats with lightsabers in time with the music.', 'beatsaber.jpg', 29.99, '2019-05-21'),
('Just Dance 2024', 'A vibrant dance rhythm game where players follow choreography to popular songs, perfect for solo or party play.', 'justdance2024.jpg', 49.99, '2023-10-24'),
('Friday Night Funkin’', 'A fast-paced indie rhythm game featuring a variety of musical battles with unique opponents.', 'fnf.jpg', 9.99, '2021-04-18'),
('Mario Party Superstars', 'A classic board-game experience featuring minigames and multiplayer mayhem from the Mario Party series.', 'mariopartysuperstars.jpg', 59.99, '2021-10-29'),
('Gang Beasts', 'A hilarious multiplayer party game where gelatinous fighters battle it out in chaotic environments.', 'gangbeasts.jpg', 19.99, '2017-12-12'),
('Jackbox Party Pack 9', 'A collection of fun and quirky party games designed for multiplayer fun, playable using mobile devices as controllers.', 'jackbox9.jpg', 29.99, '2022-10-20'),
('Genshin Impact', 'A visually stunning open-world RPG where players explore Teyvat, battle powerful foes, and uncover secrets.', 'genshinimpact.jpg', 9.99, '2020-09-28'),
('Clash Royale', 'A strategic mobile card-battle game blending tower defense and real-time strategy elements.', 'clashroyale.jpg', 4.99, '2016-03-02'),
('Among Us', 'A social deduction game where players work together to complete tasks while identifying impostors.', 'amongus.jpg', 4.99, '2018-06-15'),
('Stardew Valley', 'A charming farming simulation where players cultivate crops, raise animals, and build relationships with villagers.', 'stardewvalley.jpg', 14.99, '2016-02-26'),
('Hearthstone', 'A digital collectible card game featuring strategic deck-building and engaging battles.', 'hearthstone.jpg', 4.99, '2014-03-11'),
('Celeste', 'A challenging platformer where players climb a mountain, facing tough obstacles and an emotional narrative.', 'celeste.jpg', 19.99, '2018-01-25'),
('Terraria', 'A 2D sandbox adventure game with crafting, exploration, combat, and multiplayer elements.', 'terraria.jpg', 9.99, '2011-05-16'),
('The Binding of Isaac: Rebirth', 'A rogue-like dungeon crawler where players fight off bizarre creatures in procedurally generated levels.', 'bindingofisaac.jpg', 14.99, '2014-11-04'),
('Hollow Knight', 'A beautiful, challenging metroidvania action-adventure game set in a mysterious underground world.', 'hollowknight.jpg', 15.99, '2017-02-24'),
('Half-Life: Alyx', 'A groundbreaking VR first-person shooter set in the Half-Life universe. Fight off the alien Combine and explore a deeply immersive world.', 'halflifealyx.jpg', 59.99, '2020-03-23'),
('The Walking Dead: Saints & Sinners', 'A VR survival horror game where you scavenge, fight walkers, and make life-or-death choices in post-apocalyptic New Orleans.', 'twdsaintsandsinners.jpg', 39.99, '2020-01-23'),
('Boneworks', 'A physics-driven VR shooter with advanced interactions and sandbox combat in a mysterious experimental facility.', 'boneworks.jpg', 29.99, '2019-12-10');
GO

INSERT INTO Developers (name) VALUES
('Bethesda Game Studios'),          -- 1
('Beenox'),                          -- 2
('Turn 10 Studios'),                 -- 3
('Infinity Ward'),                    -- 4
('Capcom'),                           -- 5
('id Software'),                      -- 6
('Nintendo'),                         -- 7
('Sledgehammer Games'),               -- 8
('Rockstar Studios'),                 -- 9
('Santa Monica Studio'),              -- 10
('CD Projekt Red'),                   -- 11
('Rockstar North'),                   -- 12
('Playground Games'),                 -- 13
('Naughty Dog'),                      -- 14
('SkyBox Labs'),                      -- 15
('Raven Software'),                   -- 16
('Rockstar Games'),                   -- 17
('343 Industries'),                   -- 18
('Larian Studios'),                   -- 19
('Guerrilla Games'),                  -- 20
('FromSoftware'),                     -- 21
('Behaviour Interactive'),            -- 22
('Scott Cawthon Studios'),            -- 23
('Steel Wool Studios'),               -- 24
('Kinetic Games'),                    -- 25
('Endnight Games'),                    -- 26
('Newnight'),                         -- 27
('Frictional Games'),                 -- 28
('Maxis'),                            -- 29
('Electronic Arts'),                  -- 30
('Colossal Order'),                   -- 31
('Tantalus Media'),                   -- 32
('Giants Software'),                  -- 33
('Focus Entertainment'),              -- 34
('SCS Software'),                     -- 35
('FuturLab'),                         -- 36
('Square Enix'),                      -- 37
('Firaxis Games'),                    -- 38
('2K Games'),                         -- 39
('Creative Assembly'),                -- 40
('Relic Entertainment'),              -- 41
('Paradox Development Studio'),       -- 42
('EA Sports'),                        -- 43
('Visual Concepts'),                  -- 44
('Yuke’s'),                           -- 45
('NetherRealm Studios'),              -- 46
('Bandai Namco Studios'),             -- 47
('Arc System Works'),                 -- 48
('Sora Ltd.'),                        -- 49
('Polyphony Digital'),                -- 50
('Criterion Games'),                  -- 51
('Codemasters'),                      -- 52
('Milestone S.r.l.'),                 -- 53
('Bugbear Entertainment'),            -- 54
('Beat Games'),                      -- 55
('Ubisoft Paris'),                    -- 56
('Ubisoft Montreal'),                 -- 57
('Ubisoft San Francisco'),            -- 58
('Ninja Muffin99'),                   -- 59
('PhantomArcade'),                    -- 60
('Evilsk8r'),                         -- 61
('NDcube'),                           -- 62
('HAL Laboratory'),                   -- 63
('Boneloaf'),                         -- 64
('Coatsink'),                         -- 65
('Jackbox Games'),                    -- 66
('HoYoverse'),                           -- 67
('Supercell'),                        -- 68
('InnerSloth'),                       -- 69
('PlayEveryWare'),                    -- 70
('ConcernedApe'),                     -- 71
('Chucklefish'),                      -- 72
('Blizzard Entertainment'),           -- 73
('Maddy Makes Games'),                -- 74
('Extremely OK Games'),               -- 75
('Re-Logic'),                         -- 76
('Engine Software'),                  -- 77
('Edmund McMillen'),                  -- 78
('Nicalis'),                          -- 79
('Team Cherry'),                      -- 80
('Valve Corporation'),                 -- 81
('Skydance Interactive'),               -- 82
('Stress Level Zero');                  -- 83
GO

INSERT INTO Game_Developers (game_id, developer_id) VALUES
(1, 11),  -- Cyberpunk 2077 → CD Projekt Red
(2, 11),  -- The Witcher 3 → CD Projekt Red
(3, 12),  -- GTA V → Rockstar North
(3, 17),  -- GTA V → Rockstar Games
(4, 21),  -- Dark Souls III → FromSoftware
(5, 21),  -- Elden Ring → FromSoftware
(6, 7),   -- Super Mario Odyssey → Nintendo
(7, 7),   -- Breath of the Wild → Nintendo
(8, 6),   -- DOOM Eternal → id Software
(9, 4),   -- Call of Duty: Modern Warfare → Infinity Ward
(9, 2),   -- Call of Duty: Modern Warfare → Beenox
(9, 16),  -- Call of Duty: Modern Warfare → Raven Software
(9, 8),   -- Call of Duty: Modern Warfare → Sledgehammer Games
(10, 5),  -- Resident Evil Village → Capcom
(11, 9),  -- Red Dead Redemption 2 → Rockstar Studios
(12, 20), -- Horizon Forbidden West → Guerrilla Games
(13, 10), -- God of War Ragnarok → Santa Monica Studio
(14, 18), -- Halo Infinite → 343 Industries
(14, 15), -- Halo Infinite → SkyBox Labs
(15, 13), -- Forza Horizon 5 → Playground Games
(15, 3),  -- Forza Horizon 5 → Turn 10 Studios
(16, 5),  -- Street Fighter 6 → Capcom
(17, 14), -- The Last of Us Part II → Naughty Dog
(18, 5),  -- Monster Hunter World → Capcom
(19, 1),  -- Starfield → Bethesda Game Studios
(20, 19), -- Baldur’s Gate 3 → Larian Studios
(21, 22), (21, 27),  -- Dead by Daylight → Behaviour Interactive, Newnight
(22, 23), (22, 24),  -- Five Nights at Freddy’s: Security Breach → Scott Cawthon Studios, Steel Wool Studios
(23, 25),           -- Phasmophobia → Kinetic Games
(24, 26),           -- The Forest → Endnight Games
(25, 28),           -- Amnesia: The Bunker → Frictional Games
(26, 29), (26, 30), -- The Sims 4 → Maxis, Electronic Arts
(27, 31), (27, 32), -- Cities: Skylines II → Colossal Order, Tantalus Media
(28, 33), (28, 34), -- Farming Simulator 22 → Giants Software, Focus Entertainment
(29, 35),           -- Euro Truck Simulator 2 → SCS Software
(30, 36), (30, 37), -- PowerWash Simulator → FuturLab, Square Enix
(31, 38), (31, 39), -- Civilization VI → Firaxis Games, 2K Games
(32, 40),           -- Total War: Warhammer III → Creative Assembly
(33, 41),           -- Age of Empires IV → Relic Entertainment
(34, 38), (34, 39), -- XCOM 2 → Firaxis Games, 2K Games
(35, 42),           -- Crusader Kings III → Paradox Development Studio
(36, 43),           -- FIFA 24 → EA Sports
(37, 44),           -- NBA 2K24 → Visual Concepts
(38, 43),           -- Madden NFL 24 → EA Sports
(39, 40), (39, 24), -- Tony Hawk’s Pro Skater 1+2 → Creative Assembly, Steel Wool Studios
(40, 45),           -- WWE 2K24 → Yuke’s
(41, 46),           -- Mortal Kombat 11 → NetherRealm Studios
(42, 47),           -- Tekken 8 → Bandai Namco Studios
(43, 48),           -- Guilty Gear Strive → Arc System Works
(44, 48),           -- Dragon Ball FighterZ → Arc System Works
(45, 7), (45, 49),  -- Super Smash Bros. Ultimate → Nintendo, Sora Ltd.
(46, 50),           -- Gran Turismo 7 → Polyphony Digital
(47, 51),           -- Need for Speed: Unbound → Criterion Games
(48, 52),           -- F1 23 → Codemasters
(49, 53),           -- MotoGP 23 → Milestone S.r.l.
(50, 54),           -- Wreckfest → Bugbear Entertainment
(51, 55),                             -- Beat Saber → Beat Games
(52, 56), (52, 57), (52, 58),         -- Just Dance 2024 → Ubisoft Paris, Ubisoft Montreal, Ubisoft San Francisco
(53, 59), (53, 60), (53, 61),         -- Friday Night Funkin’ → Ninja Muffin99, PhantomArcade, Evilsk8r
(54, 62), (54, 63),                   -- Mario Party Superstars → NDcube, HAL Laboratory
(55, 64), (55, 65),                   -- Gang Beasts → Boneloaf, Coatsink
(56, 66),                             -- Jackbox Party Pack 9 → Jackbox Games
(57, 67),                             -- Genshin Impact → HoYoverse
(58, 68),                             -- Clash Royale → Supercell
(59, 69), (59, 70),                   -- Among Us → InnerSloth, PlayEveryWare
(60, 71), (60, 72),                   -- Stardew Valley → ConcernedApe, Chucklefish
(61, 73),                             -- Hearthstone → Blizzard Entertainment
(62, 74), (62, 75),                   -- Celeste → Maddy Makes Games, Extremely OK Games
(63, 76), (63, 77),                   -- Terraria → Re-Logic, Engine Software
(64, 78), (64, 79),                   -- The Binding of Isaac: Rebirth → Edmund McMillen, Nicalis
(65, 80),                             -- Hollow Knight → Team Cherry
(66, 81),                               -- Half-Life: Alyx → Valve Corporation
(67, 82),                               -- The Walking Dead: Saints & Sinners → Skydance Interactive
(68, 83);                               -- Boneworks → Stress Level Zero
GO

INSERT INTO Publishers (name) VALUES
('Bethesda Softworks'),          -- 1
('Take-Two Interactive'),         -- 2
('Sony Interactive Entertainment'), -- 3
('CD Projekt'),                   -- 4
('CD Projekt Red'),               -- 5
('Rockstar Games'),               -- 6
('Activision'),                   -- 7
('Bandai Namco Entertainment'),   -- 8
('Larian Studios'),               -- 9
('Capcom'),                       -- 10
('Xbox Game Studios'),            -- 11
('Nintendo'),                     -- 12
('Warner Bros. Interactive Entertainment'), -- 13
('FromSoftware'),                 -- 14
('505 Games'),                    -- 15
('Paradox Interactive'),          -- 16
('2K Sports'),                    -- 17
('Electronic Arts'),              -- 18
('Warner Bros. Games'),           -- 19
('SEGA'),                         -- 20
('Codemasters'),                  -- 21
('Milestone S.r.l.'),             -- 22
('Bugbear Entertainment'),        -- 23
('Square Enix'),                  -- 24
('Meta'),                          -- 25 (For Oculus VR games)
('Ubisoft'),                       -- 26 (Just Dance 2024)
('Tencent Games'),                 -- 27 (Genshin Impact, Clash Royale)
('HoYoverse'),                        -- 28 (Genshin Impact)
('InnerSloth'),                    -- 29 (Among Us)
('ConcernedApe'),                  -- 30 (Stardew Valley)
('Blizzard Entertainment'),        -- 31 (Hearthstone)
('Maddy Makes Games'),             -- 32 (Celeste)
('Re-Logic'),                      -- 33 (Terraria)
('Nicalis'),                       -- 34 (The Binding of Isaac: Rebirth)
('Team Cherry'),                   -- 35 (Hollow Knight)
('Valve Corporation'),             -- 36 (Half-Life: Alyx)
('Skydance Interactive'),          -- 37 (The Walking Dead: Saints & Sinners)
('Stress Level Zero');             -- 38 (Boneworks)
GO

-- Insert into Game_Publishers (Many-to-Many)
-- Each game can have multiple publishers handling distribution.
INSERT INTO Game_Publishers (game_id, publisher_id) VALUES
(1, 5),    -- Cyberpunk 2077 → CD Projekt Red
(2, 4),    -- The Witcher 3 → CD Projekt
(2, 8),    -- The Witcher 3 → Bandai Namco Entertainment
(2, 13),   -- The Witcher 3 → Warner Bros. Interactive Entertainment
(3, 6),    -- GTA V → Rockstar Games
(3, 2),    -- GTA V → Take-Two Interactive
(4, 8),    -- Dark Souls III → Bandai Namco Entertainment
(4, 14),   -- Dark Souls III → FromSoftware
(5, 8),    -- Elden Ring → Bandai Namco Entertainment
(5, 14),   -- Elden Ring → FromSoftware
(6, 12),   -- Super Mario Odyssey → Nintendo
(7, 12),   -- Breath of the Wild → Nintendo
(8, 1),    -- DOOM Eternal → Bethesda Softworks
(9, 7),    -- Call of Duty: Modern Warfare → Activision
(10, 10),  -- Resident Evil Village → Capcom
(11, 6),   -- Red Dead Redemption 2 → Rockstar Games
(11, 2),   -- Red Dead Redemption 2 → Take-Two Interactive
(12, 3),   -- Horizon Forbidden West → Sony Interactive Entertainment
(13, 3),   -- God of War Ragnarok → Sony Interactive Entertainment
(14, 11),  -- Halo Infinite → Xbox Game Studios
(15, 11),  -- Forza Horizon 5 → Xbox Game Studios
(16, 10),  -- Street Fighter 6 → Capcom
(17, 3),   -- The Last of Us Part II → Sony Interactive Entertainment
(18, 10),  -- Monster Hunter World → Capcom
(19, 1),   -- Starfield → Bethesda Softworks
(20, 9),   -- Baldur’s Gate 3 → Larian Studios
(21, 15), (21, 24),  -- Dead by Daylight → 505 Games, Square Enix
(22, 19), (22, 24),  -- Five Nights at Freddy’s: Security Breach → Warner Bros. Games, Square Enix
(23, 15),            -- Phasmophobia → 505 Games
(24, 15),            -- The Forest → 505 Games
(25, 19),            -- Amnesia: The Bunker → Warner Bros. Games
(26, 18),            -- The Sims 4 → Electronic Arts
(27, 16),            -- Cities: Skylines II → Paradox Interactive
(28, 15),            -- Farming Simulator 22 → 505 Games
(29, 15),            -- Euro Truck Simulator 2 → 505 Games
(30, 24),            -- PowerWash Simulator → Square Enix
(31, 20),            -- Civilization VI → SEGA
(32, 20),            -- Total War: Warhammer III → SEGA
(33, 20),            -- Age of Empires IV → SEGA
(34, 19),            -- XCOM 2 → Warner Bros. Games
(35, 16),            -- Crusader Kings III → Paradox Interactive
(36, 18),            -- FIFA 24 → Electronic Arts
(37, 17),            -- NBA 2K24 → 2K Sports
(38, 18),            -- Madden NFL 24 → Electronic Arts
(39, 7),            -- Tony Hawk’s Pro Skater 1+2 → Activision
(40, 17),           -- WWE 2K24 → 2K Sports
(41, 19),           -- Mortal Kombat 11 → Warner Bros. Games
(42, 8),            -- Tekken 8 → Bandai Namco Entertainment
(43, 8),            -- Guilty Gear Strive → Bandai Namco Entertainment
(44, 8),            -- Dragon Ball FighterZ → Bandai Namco Entertainment
(45, 12),           -- Super Smash Bros. Ultimate → Nintendo
(46, 12),           -- Gran Turismo 7 → Nintendo
(47, 18),           -- Need for Speed: Unbound → Electronic Arts
(48, 21),           -- F1 23 → Codemasters
(49, 22),           -- MotoGP 23 → Milestone S.r.l.
(50, 23),           -- Wreckfest → Bugbear Entertainment
(51, 25),                -- Beat Saber → Meta (Oculus VR)
(52, 26),                -- Just Dance 2024 → Ubisoft
(53, 15),                -- Friday Night Funkin’ → 505 Games
(54, 12),                -- Mario Party Superstars → Nintendo
(55, 15),                -- Gang Beasts → 505 Games
(56, 15),                -- Jackbox Party Pack 9 → 505 Games
(57, 27), (57, 28),      -- Genshin Impact → Tencent Games, HoYoverse
(58, 27),                -- Clash Royale → Tencent Games
(59, 29),                -- Among Us → InnerSloth
(60, 30),                -- Stardew Valley → ConcernedApe
(61, 31),                -- Hearthstone → Blizzard Entertainment
(62, 32),                -- Celeste → Maddy Makes Games
(63, 33),                -- Terraria → Re-Logic
(64, 34),                -- The Binding of Isaac: Rebirth → Nicalis
(65, 35),                -- Hollow Knight → Team Cherry
(66, 36),                -- Half-Life: Alyx → Valve Corporation
(67, 37),                -- The Walking Dead: Saints & Sinners → Skydance Interactive
(68, 38);                -- Boneworks → Stress Level Zero
GO

-- Insert Genres
INSERT INTO Genres (name) VALUES
('Adventure'),
('Action'),
('RPG'),
('Shooter'),
('Strategy'),
('Simulation'),
('Horror'),
('Sports'),
('Fighting'),
('Racing'),
('Platformer'),
('Survival'),
('Open World'),
('Stealth'),
('Party'),
('Rhythm');
GO

-- Insert into Game_Genres (Many-to-Many)
INSERT INTO Game_Genres (game_id, genre_id) VALUES
(1, 3), (1, 4),  -- Cyberpunk 2077 → RPG, Shooter
(2, 3), (2, 2),  -- The Witcher 3 → RPG, Action
(3, 4), (3, 13), -- GTA V → Shooter, Open World
(4, 3), (4, 1),          -- Dark Souls III → RPG, Adventure
(5, 3), (5, 1),		     -- Elden Ring → RPG, Adventure
(6, 11), (6, 1),			-- Super Mario Odyssey → Platformer
(7, 3), (7, 12), (7, 13),  -- Zelda: Breath of the Wild → RPG, Survival, Open World
(8, 4), (8, 7),				-- DOOM Eternal → Shooter, Horror
(9, 4),						-- Call of Duty: Modern Warfare → Shooter
(10, 7), (10, 2),			-- Resident Evil Village → Horror, Action
(11, 3), (11, 13),			-- Red Dead Redemption 2 → RPG, Open World
(12, 2), (12, 13),			-- Horizon Forbidden West → Action, Open World
(13, 2), (13, 3),			-- God of War Ragnarok → Action, RPG
(14, 4),					-- Halo Infinite → Shooter
(15, 10), (15, 13),			-- Forza Horizon 5 → Racing, Open World
(16, 9),					-- Street Fighter 6 → Fighting
(17, 4), (17, 7), (17, 14), -- The Last of Us Part II → Shooter, Horror, Stealth
(18, 3), (18, 2),			 -- Monster Hunter World → RPG, Action
(19, 3), (19, 4), (19, 13), -- Starfield → RPG, Shooter, Open World
(20, 3), (20, 2),			-- Baldur’s Gate 3 → RPG, Action
(21, 7), (21, 12),			-- Dead by Daylight → Horror, Survival
(22, 7), (22, 14),				-- Five Nights at Freddy’s: Security Breach → Horror, Stealth
(23, 7), (23, 6),			-- Phasmophobia → Horror, Simulation
(24, 7), (24, 6), (24, 12),  -- The Forest → Horror, Simulation, Survival
(25, 7), (25, 12), (25, 14),  -- Amnesia: The Bunker → Horror, Survival, Stealth
(26, 6),  -- The Sims 4 → Simulation
(27, 6),  -- Cities: Skylines II → Simulation
(28, 6),  -- Farming Simulator 22 → Simulation
(29, 6),  -- Euro Truck Simulator 2 → Simulation
(30, 6),  -- PowerWash Simulator → Simulation
(31, 5),  -- Civilization VI → Strategy
(32, 5),  -- Total War: Warhammer III → Strategy
(33, 5),  -- Age of Empires IV → Strategy
(34, 5),  -- XCOM 2 → Strategy
(35, 5),  -- Crusader Kings III → Strategy
(36, 8),  -- FIFA 24 → Sports
(37, 8),  -- NBA 2K24 → Sports
(38, 8),  -- Madden NFL 24 → Sports
(39, 8),  -- Tony Hawk’s Pro Skater 1+2 → Sports
(40, 9),  -- WWE 2K24 → Fighting
(41, 9),  -- Mortal Kombat 11 → Fighting
(42, 9),  -- Tekken 8 → Fighting
(43, 9),  -- Guilty Gear Strive → Fighting
(44, 9),  -- Dragon Ball FighterZ → Fighting
(45, 11), (45, 16),  -- Super Smash Bros. Ultimate → Platformer, Party
(46, 10),  -- Gran Turismo 7 → Racing
(47, 10),  -- Need for Speed: Unbound → Racing
(48, 10),  -- F1 23 → Racing
(49, 10),  -- MotoGP 23 → Racing
(50, 10),  -- Wreckfest → Racing
(51, 15),  -- Beat Saber → Rhythm
(52, 15),  -- Just Dance 2024 → Rhythm
(53, 15),  -- Friday Night Funkin’ → Rhythm
(54, 16),  -- Mario Party Superstars → Party
(55, 16),  -- Gang Beasts → Party
(56, 16),  -- Jackbox Party Pack 9 → Party
(57, 3), (57, 13),  -- Genshin Impact → RPG, Open World
(58, 5), (58, 6),  -- Clash Royale → Strategy, Simulationp
(59, 6), (59, 16),  -- Among Us → Simulation, Party
(60, 6), (60, 3),  -- Stardew Valley → Simulation, RPG
(61, 5), (61, 3),  -- Hearthstone → Strategy, RPG
(62, 11), (62, 1),	-- Celeste → Platformer, Adventure
(63, 3), (63, 12),  -- Terraria → RPG, Survival
(64, 6), (64, 12),  -- The Binding of Isaac: Rebirth → Simulation, Survival
(65, 11), (65, 2),  -- Hollow Knight → Platformer, Action
(66, 4), (66, 2),			-- Half-Life: Alyx → Shooter, Action
(67, 7),			  -- The Walking Dead: Saints & Sinners → Horror
(68, 4), (68, 6);		-- Boneworks → Shooter, Simulation
GO

-- Insert Categories (Store Categories)
INSERT INTO Categories (name) VALUES
('Best Sellers'),          -- Most popular games
('New & Trending'),        -- New releases and currently popular titles
('Pre-Orders'),            -- Upcoming games available for early purchase
('Top Rated'),             -- Games with highest rating
('Cozy & Casual'),         -- Relaxing, easy-to-play games
('Multiplayer & Online'),  -- Games with online/co-op modes
('Single-Player Favorites'); -- Games designed for solo play
GO

-- Insert into Game_Categories (Many-to-Many)
-- Each game can appear in multiple store categories.
INSERT INTO Game_Categories (game_id, category_id) VALUES
(1, 1),  -- Cyberpunk 2077 → Best Sellers
(1, 2),  -- Cyberpunk 2077 → New & Trending
(1, 7),  -- Cyberpunk 2077 → Single-Player Favorites
(2, 1),  -- The Witcher 3 → Best Sellers
(2, 4),  -- The Witcher 3 → Top Rated
(2, 7),  -- The Witcher 3 → Single-Player Favorites
(3, 1),  -- GTA V → Best Sellers
(3, 6),  -- GTA V → Multiplayer & Online
(3, 2),  -- GTA V → New & Trending
(4, 7),  -- Dark Souls III → Single-Player Favorites
(4, 4),  -- Dark Souls III → Top Rated
(5, 1),  -- Elden Ring → Best Sellers
(5, 4),  -- Elden Ring → Top Rated
(5, 7),  -- Elden Ring → Single-Player Favorites
(6, 1),  -- Super Mario Odyssey → Best Sellers
(6, 5),  -- Super Mario Odyssey → Cozy & Casual
(6, 7),  -- Super Mario Odyssey → Single-Player Favorites
(7, 7),  -- The Legend of Zelda: Breath of the Wild → Single-Player Favorites
(7, 4),  -- The Legend of Zelda: Breath of the Wild → Top Rated
(8, 2),  -- DOOM Eternal → New & Trending
(8, 7),  -- DOOM Eternal → Single-Player Favorites
(8, 1),  -- DOOM Eternal → Best Sellers
(9, 6),  -- Call of Duty: Modern Warfare → Multiplayer & Online
(9, 1),  -- Call of Duty: Modern Warfare → Best Sellers
(10, 3), -- Resident Evil Village → Pre-Orders
(10, 7), -- Resident Evil Village → Single-Player Favorites
(11, 1), -- Red Dead Redemption 2 → Best Sellers
(11, 4), -- Red Dead Redemption 2 → Top Rated
(11, 7), -- Red Dead Redemption 2 → Single-Player Favorites
(12, 1), -- Horizon Forbidden West → Best Sellers
(12, 4), -- Horizon Forbidden West → Top Rated
(12, 7), -- Horizon Forbidden West → Single-Player Favorites
(13, 3), -- God of War Ragnarok → Pre-Orders
(13, 7), -- God of War Ragnarok → Single-Player Favorites
(14, 6), -- Halo Infinite → Multiplayer & Online
(14, 1), -- Halo Infinite → Best Sellers
(15, 6), -- Forza Horizon 5 → Multiplayer & Online
(15, 1), -- Forza Horizon 5 → Best Sellers
(16, 6), -- Street Fighter 6 → Multiplayer & Online
(16, 2), -- Street Fighter 6 → New & Trending
(17, 7), -- The Last of Us Part II → Single-Player Favorites
(18, 2), -- Monster Hunter World → New & Trending
(19, 3), -- Starfield → Pre-Orders
(20, 1), -- Baldur’s Gate 3 → Best Sellers
(20, 4), -- Baldur’s Gate 3 → Top Rated
(20, 7), -- Baldur’s Gate 3 → Single-Player Favorites
(21, 6), (21, 2),  -- Dead by Daylight → Multiplayer & Online, New & Trending
(22, 7),           -- Five Nights at Freddy’s: Security Breach → Single-Player Favorites
(23, 6), (23, 2),  -- Phasmophobia → Multiplayer & Online, New & Trending
(24, 7),           -- The Forest → Single-Player Favorites
(25, 3), (25, 7),  -- Amnesia: The Bunker → Pre-Orders, Single-Player Favorites
(26, 5),           -- The Sims 4 → Cozy & Casual
(27, 1),           -- Cities: Skylines II → Best Sellers
(28, 1),           -- Farming Simulator 22 → Best Sellers
(29, 5),           -- Euro Truck Simulator 2 → Cozy & Casual
(30, 5),           -- PowerWash Simulator → Cozy & Casual
(31, 1), (31, 4),  -- Civilization VI → Best Sellers, Top Rated
(32, 4),           -- Total War: Warhammer III → Top Rated
(33, 4),           -- Age of Empires IV → Top Rated
(34, 1),           -- XCOM 2 → Best Sellers
(35, 1), (35, 7),  -- Crusader Kings III → Best Sellers, Single-Player Favorites
(36, 1), (36, 6),  -- FIFA 24 → Best Sellers, Multiplayer & Online
(37, 1),           -- NBA 2K24 → Best Sellers
(38, 1), (38, 6),  -- Madden NFL 24 → Best Sellers, Multiplayer & Online
(39, 6),           -- Tony Hawk’s Pro Skater 1+2 → Multiplayer & Online
(40, 1), (40, 6),  -- WWE 2K24 → Best Sellers, Multiplayer & Online
(41, 1),           -- Mortal Kombat 11 → Best Sellers
(42, 1), (42, 6),  -- Tekken 8 → Best Sellers, Multiplayer & Online
(43, 2), (43, 6),  -- Guilty Gear Strive → New & Trending, Multiplayer & Online
(44, 1), (44, 6),  -- Dragon Ball FighterZ → Best Sellers, Multiplayer & Online
(45, 1),           -- Super Smash Bros. Ultimate → Best Sellers
(46, 1), (46, 4),  -- Gran Turismo 7 → Best Sellers, Top Rated
(47, 2), (47, 6),  -- Need for Speed: Unbound → New & Trending, Multiplayer & Online
(48, 1), (48, 4),  -- F1 23 → Best Sellers, Top Rated
(49, 1),           -- MotoGP 23 → Best Sellers
(50, 6), (50, 2),  -- Wreckfest → Multiplayer & Online, New & Trending
(51, 2), (51, 6),  -- Beat Saber → New & Trending, Multiplayer & Online
(52, 1), (52, 5),  -- Just Dance 2024 → Best Sellers, Cozy & Casual
(53, 2), (53, 6),  -- Friday Night Funkin’ → New & Trending, Multiplayer & Online
(54, 6), (54, 5),  -- Mario Party Superstars → Multiplayer & Online, Cozy & Casual
(55, 6), (55, 2),  -- Gang Beasts → Multiplayer & Online, New & Trending
(56, 6), (56, 5),  -- Jackbox Party Pack 9 → Multiplayer & Online, Cozy & Casual
(57, 1), (57, 4),  -- Genshin Impact → Best Sellers, Top Rated
(58, 6), (58, 2),  -- Clash Royale → Multiplayer & Online, New & Trending
(59, 6), (59, 5),  -- Among Us → Multiplayer & Online, Cozy & Casual
(60, 5), (60, 7),  -- Stardew Valley → Cozy & Casual, Single-Player Favorites
(61, 1), (61, 4),  -- Hearthstone → Best Sellers, Top Rated
(62, 7), (62, 4),  -- Celeste → Single-Player Favorites, Top Rated
(63, 7), (63, 4),  -- Terraria → Single-Player Favorites, Top Rated
(64, 5), (64, 7),  -- The Binding of Isaac: Rebirth → Cozy & Casual, Single-Player Favorites
(65, 7), (65, 4),  -- Hollow Knight → Single-Player Favorites, Top Rated
(66, 1), (66, 2),  -- Half-Life: Alyx → Best Sellers, New & Trending
(67, 7), (67, 2),  -- The Walking Dead: Saints & Sinners → Single-Player Favorites, New & Trending
(68, 6), (68, 2);  -- Boneworks → Multiplayer & Online, New & Trending
GO

-- Insert Platforms
INSERT INTO Platforms (name) VALUES
('Windows'),
('PlayStation'),
('Xbox'),
('Nintendo Switch'),
('Mobile'),
('VR'),
('Mac'),
('Linux');
GO

-- Insert into Game_Platforms (Many-to-Many)
-- Each game is available on one or more platforms.
INSERT INTO Game_Platforms (game_id, platform_id) VALUES
(1, 1),  -- Cyberpunk 2077 → Windows
(1, 2),  -- Cyberpunk 2077 → PlayStation
(1, 3),  -- Cyberpunk 2077 → Xbox
(2, 1),  -- The Witcher 3 → Windows
(2, 2),  -- The Witcher 3 → PlayStation
(2, 3),  -- The Witcher 3 → Xbox
(2, 4),  -- The Witcher 3 → Nintendo Switch
(3, 1),  -- GTA V → Windows
(3, 2),  -- GTA V → PlayStation
(3, 3),  -- GTA V → Xbox
(4, 1),  -- Dark Souls III → Windows
(4, 2),  -- Dark Souls III → PlayStation
(4, 3),  -- Dark Souls III → Xbox
(5, 1),  -- Elden Ring → Windows
(5, 2),  -- Elden Ring → PlayStation
(5, 3),  -- Elden Ring → Xbox
(6, 4),  -- Super Mario Odyssey → Nintendo Switch
(7, 4),  -- Breath of the Wild → Nintendo Switch
(8, 1),  -- DOOM Eternal → Windows
(8, 2),  -- DOOM Eternal → PlayStation
(8, 3),  -- DOOM Eternal → Xbox
(9, 1),  -- Call of Duty: Modern Warfare → Windows
(9, 2),  -- Call of Duty: Modern Warfare → PlayStation
(9, 3),  -- Call of Duty: Modern Warfare → Xbox
(10, 1), -- Resident Evil Village → Windows
(10, 2), -- Resident Evil Village → PlayStation
(10, 3), -- Resident Evil Village → Xbox
(11, 1), -- Red Dead Redemption 2 → Windows
(11, 2), -- Red Dead Redemption 2 → PlayStation
(11, 3), -- Red Dead Redemption 2 → Xbox
(12, 2), -- Horizon Forbidden West → PlayStation
(13, 2), -- God of War Ragnarok → PlayStation
(14, 1), -- Halo Infinite → Windows
(14, 3), -- Halo Infinite → Xbox
(15, 1), -- Forza Horizon 5 → Windows
(15, 3), -- Forza Horizon 5 → Xbox
(16, 1), -- Street Fighter 6 → Windows
(16, 2), -- Street Fighter 6 → PlayStation
(16, 3), -- Street Fighter 6 → Xbox
(17, 2), -- The Last of Us Part II → PlayStation
(18, 1), -- Monster Hunter World → Windows
(18, 2), -- Monster Hunter World → PlayStation
(18, 3), -- Monster Hunter World → Xbox
(19, 1), -- Starfield → Windows
(19, 3), -- Starfield → Xbox
(20, 1), -- Baldur’s Gate 3 → Windows
(20, 2), -- Baldur’s Gate 3 → PlayStation
(20, 3), -- Baldur’s Gate 3 → Xbox
(20, 7), -- Baldur’s Gate 3 → Mac
(20, 8), -- Baldur’s Gate 3 → Linux
(21, 1), (21, 2), (21, 3),  -- Dead by Daylight → Windows, PlayStation, Xbox
(22, 1), (22, 2), (22, 4),  -- Five Nights at Freddy’s: Security Breach → Windows, PlayStation, Nintendo Switch
(23, 1), (23, 6),           -- Phasmophobia → Windows, VR
(24, 1), (24, 2), (24, 3),  -- The Forest → Windows, PlayStation, Xbox
(25, 1), (25, 2),           -- Amnesia: The Bunker → Windows, PlayStation
(26, 1), (26, 2), (26, 3),  -- The Sims 4 → Windows, PlayStation, Xbox
(27, 1),                    -- Cities: Skylines II → Windows
(28, 1), (28, 2), (28, 3),  -- Farming Simulator 22 → Windows, PlayStation, Xbox
(29, 1),                    -- Euro Truck Simulator 2 → Windows
(30, 1), (30, 2),           -- PowerWash Simulator → Windows, PlayStation
(31, 1), (31, 2),           -- Civilization VI → Windows, PlayStation
(32, 1),                    -- Total War: Warhammer III → Windows
(33, 1), (33, 3),           -- Age of Empires IV → Windows, Xbox
(34, 1), (34, 2),           -- XCOM 2 → Windows, PlayStation
(35, 1),                    -- Crusader Kings III → Windows
(36, 1), (36, 2), (36, 3),  -- FIFA 24 → Windows, PlayStation, Xbox
(37, 1), (37, 2), (37, 3),  -- NBA 2K24 → Windows, PlayStation, Xbox
(38, 1), (38, 2), (38, 3),  -- Madden NFL 24 → Windows, PlayStation, Xbox
(39, 1), (39, 2),           -- Tony Hawk’s Pro Skater 1+2 → Windows, PlayStation
(40, 1), (40, 2), (40, 3),  -- WWE 2K24 → Windows, PlayStation, Xbox
(41, 1), (41, 2), (41, 3),  -- Mortal Kombat 11 → Windows, PlayStation, Xbox
(42, 1), (42, 2), (42, 3),  -- Tekken 8 → Windows, PlayStation, Xbox
(43, 1), (43, 2),           -- Guilty Gear Strive → Windows, PlayStation
(44, 1), (44, 2), (44, 3),  -- Dragon Ball FighterZ → Windows, PlayStation, Xbox
(45, 4),                    -- Super Smash Bros. Ultimate → Nintendo Switch
(46, 1), (46, 2),           -- Gran Turismo 7 → Windows, PlayStation
(47, 1), (47, 2), (47, 3),  -- Need for Speed: Unbound → Windows, PlayStation, Xbox
(48, 1), (48, 2), (48, 3),  -- F1 23 → Windows, PlayStation, Xbox
(49, 1), (49, 2),           -- MotoGP 23 → Windows, PlayStation
(50, 1), (50, 2),           -- Wreckfest → Windows, PlayStation
(51, 1), (51, 6),        -- Beat Saber → Windows, VR
(52, 1), (52, 2), (52, 4), -- Just Dance 2024 → Windows, PlayStation, Nintendo Switch
(53, 1), (53, 5),        -- Friday Night Funkin’ → Windows, Mobile
(54, 4),                 -- Mario Party Superstars → Nintendo Switch
(55, 1), (55, 2), (55, 3), -- Gang Beasts → Windows, PlayStation, Xbox
(56, 1), (56, 4), (56, 5), -- Jackbox Party Pack 9 → Windows, Nintendo Switch, Mobile
(57, 1), (57, 2), (57, 3), (57, 5), -- Genshin Impact → Windows, PlayStation, Xbox, Mobile
(58, 5),                 -- Clash Royale → Mobile
(59, 1), (59, 2), (59, 3), (59, 4), (59, 5), -- Among Us → Windows, PlayStation, Xbox, Nintendo Switch, Mobile
(60, 1), (60, 4), (60, 5), -- Stardew Valley → Windows, Nintendo Switch, Mobile
(61, 1), (61, 5),        -- Hearthstone → Windows, Mobile
(62, 1), (62, 8),        -- Celeste → Windows, Linux
(63, 1), (63, 8),        -- Terraria → Windows, Linux
(64, 1), (64, 7),        -- The Binding of Isaac: Rebirth → Windows, Mac
(65, 1), (65, 7),        -- Hollow Knight → Windows, Mac
(66, 1), (66, 6),        -- Half-Life: Alyx → Windows, VR
(67, 1), (67, 6),        -- The Walking Dead: Saints & Sinners → Windows, VR
(68, 1), (68, 6);        -- Boneworks → Windows, VR
GO

INSERT INTO Coupons (code, discount_percentage, expiration_date, usage_limit) VALUES
('WELCOME10', 10, '2025-12-31', 1000),
('SUMMER20', 20, '2025-08-31', 500),
('BLACKFRIDAY50', 50, '2025-11-29', 200);
GO