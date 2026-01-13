-- ASCII Moon Phase Viewer for Neovim
local M = {}

-- Constants
local SYNODIC_MONTH = 29.53058867
local KNOWN_NEW_MOON_SEC = 947182440 -- January 6, 2000 at 18:14 UTC

local MOON_ART_RAW = [[
                                                                                    #@&&%#%&(#&###&%###&&&&#/(@&(###.  %/#,                                                                             
                                                                            #&%%#&@%(&%##(*%&%##(###&&%&%#(#%&%%%&%###%(%#(#((@&&&(/.                                                                   
                                                                   .%&&##%###/%%#%%#&,%%&%%%%#%%%%%%&&&&%%%%##%&(#(%&(###%/##&##%(*(&%@#%*%/                                                            
                                                             /#/%&%#%(@%##%(((#&&&%%%%&%%%%&%&&&&&&&%%%%%%%%%%%#####%#%&#%#%%%%%%%%&&&&%%.%%%%%*(                                                       
                                                       ,(.@&%((#(@%#&%###(####((%&%%%%%%%&&&&&&&#&&&&&%%%##%###%####(%#%##%#%%%%%%&&%&&(%&&&&%&&%&&&#,                                                  
                                                   /(*/**,.%#((((*###%###((###%##%(%%%#%%%%%%%%%%%%#%%%%%%##%########%(####%%%%%%%%%&&&&%#%%%&%%&%%%%%%&#&                                              
                                               /*/((%%(#####((%((((((((#((#(##(###########%#%%#&%###%##(#%%%%#####(#%#(((##&#%##%%&&&%&%%%%%%%%#%/#%(#(/%%%###                                          
                                           ,*/,(/%/#/((#((((/(((((*//(////((#((#//(/((((#########(#(##(#(##(#(#%%((((#(#####&%###%%%%%&%&&&%%%%%#%%###(((##(*,,,/((##/####                                   
                                        .,.,///((/(((/(/*((/&*////**/*//********////((((((((#(##(##((#(#(#%%((((#(#####&%###%%%%%&%&&&%%%%%#%%###(((##(*,,,/((##/####                                   
                                     .,,,**////*********,,,*,**//(//***********//*****/*,**////((/((///((((((((((##(####%#((###%%%%%&&&&%%%&####%&(((((##((%####%((%(#&*                                
                                  ..,,,*,*,*,.,******//******,,*///////*****/******/********/////*/(/((///////(/(((//(/((((((((((#%%%%%&%&%%&%((#%#%(#(###(((#((#(##((#%%*@                             
                               ,..,.,,,*,*....,,,*//(*/////((/(((((//(/**/*/***/((((((///**///////////((///////**(////*********(#/###%#%%%%#%&%///(%####(##(//(((((#((#(/(#(*                           
                             ......,,,,,*,,.,,,****#&(((((#((/////(#//*/((####((//((//(((((((///////////((///////*//*/*/*/*******//((##%#%%#%%(#%%#%%%#(((#%##(##(%(#((((##(%*#*#                        
                           ........,,,,**,*/*///(((((((%#/////(/(%/////**//##(#*,,,*#/(/(%%%#*//((/////////*/////*////***/******(((((#%##%########%(((##((###%%(#((%(((###%((#((%#                      
                        ..........,,....,*///((//(((%##((((//(/(/*****,,,,***//(*/((*/(((#(####((#////(////###(#(((///(*///#((///###%####%#(##%####(///((####%###(##/(((####(##%#,%%                    
                      .........,........,/(//((//#(,,,,,**,**//**,,,,,,,,,**/******//(#%((((((##((/(/*/////(#(/(((//(((((((/////(###(%%%####%%%#%&##((/(/*//((#(*((##(######(((((##(#@                  
                    ...............,..,***/*////(/*,,,,*,,,,,.....,,,,,,,,************//(#%(#(##(((///((((/(((((((#(((((////////#(((###(#####%###%##((((((((((/#((/((##%&%%##(((%(%/(#(%                
                   ..................**/////*/(//,,,,.,,,,,.........,,,,*,,,,**,*,********//#/((###(##((((##((###(%#####(///(##(/#((//(((((((((########(#(##(%#((#%((##(#((%####(##%###((%%               
                 ...............,,,,*//**//*//*,**,.............,,.,,,,,,,***,*#,****/****##(((((###(((((###%##%(((#(((///////#(#((%(#(((((((((#######(///%##(#((###(#(((#((((((#(%#(#(//(#             
               ..,,............,,,,*******(/,,...,......,..,..,,,,,.,,,,**,,,,,*,***/*****/%(/(#/####((#(##(####((#(/((/(/#//###(((((//(//(#%#####%#%##/##((###%#%#((((#(//((((#/((##(((#((,            
              ................,.,,,,**,***,,,.,,,,,,................,,,,/,,,,,,********#//////###/(((###%%(((###((((/(/****/(///((/(///*(//(%#((#####((((########%%##(%(((((##((((#####%##((((          
            /*..............,,..,,.,.,*,,...,...,......,........,.,.,,,,*,,,,,*******//////////////#%%%%####(##((#(((((/**/*////((((((****/(#%###((((#####(%#%##%%&%#%(#((##%/#%(##((##(%%##(##         
           (.,.........,.,..,,,,...,,*,,....,,,,,,,,.,,,......,,,,,,,,,,**,,,,,,****///*////*(/((/(###(#(/****//(((((((/***(//***(//**/***//(((#%##%%%###(((##((##%%%##((((((###%(#########(#///        
           ..........,...,,,,,,,,,,,,,,..,,,,,.......,..,...,,.,,,,,,,,,,,,,,,******/**//**/**//(##((**,*,,,,,****/*/(((**,,**///(/****//((///(%%%#%#%#%(#(###%#%%%((((/%(((##&#%#&###%#%%#(*//       
         ,/.........,.,.,./,**,,,,,,,**,,,,,,,,...........,....,,,,...,,,,,,.,,*(*,***//#///***/**((#((*******,********,,***,****//(((////(####%%%#####&%%#%#(#%####%#(((##(#(#(((#(####%(#%%(##(/      
        ..............,,*/,,,,*,,,,.,.,,,,,,,,,,,,,,....,,,,,,,,,,,,,,,,,,,,,,,,*****////*****//////,,,,,,,,,,*,*,,,,,**,,,,,,/(##%%((///#%#%%##%%#%##%%%##%%###%&###(######%####/%(((##%###/#((#     
       ..............,,*//*,,****,,,,,*(,,*,,.,,,,.,,..,,,...,*,,,,,,,,,,,,,,**///**///((///****(***,,,,...,,,,,,,,,,,***,,,,,,*/((%((((####(%%%%%%%%&###%%%%###(###((##%%#(/((/((###%###%&###/(///    
      ...,..........,/*&&***,***,,,,,,,,,,,.,..,,,(,,,,,,,.,,,,,,,,,,,,,,,,,,/****//////////*******,,,,,,,,,,,,,,,,,,***,,,,,,,,,**//((((#%##%##%##%%####%&%#(###%(//((/#(#((/#&*%/##(((####((##((//   
     %.............,*,*****,,,*,,.,,..*...,,,..,,*,,,,,,,,..,,,,,,*****,,***///*/*****//(((//*/(/*/,,,*,,,,,,,,,,,,,,,*,*,,,,,....,,///(##%%%%%%%####%(##%((##(###/(((#(##*//**/(//,%((((((##%(((/##/   
     ...............,,,,,***,,,....,,..,,..,,,,,,,,,,,,,*,..,*,,,,*/***,**/////(///****,,**//((///*,,,,,,.,,,,,,,*,,,,,,,,,,....,,*/(###%&&%%%#%%%%#(*/((((((//((#%/*,*,,*,,*,(//((/(##((((/,,(///  
    ................,....*,*,,.,,,,,.,,,,,*/*,,.,*,*,,,,*,,,*,,,,,,,,,,,,**//////(//**,***,*/////*,,,,,,.,,,,,,,,,,,**,,,,.,,,,,,,.,**////%(#%%###%####(#/(#((/(((//(*******,,,,.,,.,*//(/%(//((*,,,,*. 
    .......................,***,,.,,.,,,*,*****,*,***,,,,**,**,,,,*,*,,,,,,,,*/(/////(//*/(/((%(/**.,,.......,,,,,,,*,,,,,,,,,,,,,,.,,*////(((#(//#(%#%#(#/(#((((((((****,*,,,,,.....*.,(/(##//(//,.,,,/ 
    ,,...............*....,,,*,,,*...,..,,,*/*,*,**,,,/(,*,,,**,,,,,*,,,,,,,,,,,***/(#((%##(((///*,,..........,.,,,**,,,,,,,.,,,,,,,,.(,*/(#((((/**//%&#(/#(##(####(/***,,,,,,,,,....,..*#(##(/,/**...,* 
    /,*...................,,,,****..,,,.***,,*,,**,***,,,**,*,*,**,,**,,,,*,,,,,,,**(/((#(##(//*/**,,......,,,,,,,,,*,,,,,,,,,,,,,,.,.,**/(((/////**/((#((####%#&#%#((/*,,,,,,,,,.....,,,(((##(#/,//,*,,/*
    */,...................,,,,****.*,,..,,*******/**/****,**,********,,,*/*,,.,,/*,/((/((///(((////*,*,,,..,/....,,,,,,,,,,,*,,,,,,....,/*//////,,******,*/(((%&&&%&&%%#/*,,,,,..,....,*((/((###/(#(//(**/*
    (*,...............,,.,,,*****,,..*/***(##///////**/******/*/*//*********,,/(/((////(//(/**//*,**,/*,****,/**,,,,,,,*,,,,,,,...,,,.,...,,/*******,,,,,//(((((((#%%%#/(/*,,*.,,..,....,/##(*((((((((/*,*/*
    (*,..................,,,******,*,*,,***/(*(/*/(((///(*//*//*/((/**/////////////////****,********,,,,**,,,*,/(/(*.,,(,.,,......,,,,.....,,***,,,,,,,,*//(%((/(#&%#%#/**,,,,,,,,.,.,*(#/((#,(((((/(//***
    (*#*...................*,*//**/**.,,,*///((((//*(((#((((///*///(///*,*,,,,***/////**,,,,,,,,,,,,,*/((/****,,,/(((#/***/*..,/*..........,....,,..,,...*,/(/((/(##%%#%#(///,,.,,,,,///#((/,*(,/(#/#(/(*,*
    /(/*,..........,....,.,**///(//**,,,,**((/(#(((///###((((///////*//*****,,,,,,,****,,,,*,,,,,,,,,,/#((/*,,**/**,#**/*,...............,.,,................,,*/((//#####(###//*(/#/(////#,.(,,//(((#//..,
    *((*................,***//#(////**,,****//(//(((#%%%&%(///(/////*/******,,,,,...,,*,,,,,,,,..,,.....,**,,//*///#///,,............,,*,,................*...,*,**/(######(##(((((((//*,/,.**/,#//(/#/,...
    ,(#,.................,,***/(((/**,,,,*,,**/(((((#%%%%%%(///////////***,,,,,,.,..,,***,,,,..,,.....,**,,//*///#///,,............,,*,,................*...,,//*/*****/(((((((/(((((((/(//*//,#/*/(/%(,,.,
    #*,.................,*,,/*////,,**//**#***//(//*/////*//////**//****,,,,**,,***///////***,,,,,.,.,****,((/(/**//*,,.....................,.............*/*,*****,*,***/((%####(((*(/((,(////,**//**....
    /**..................,**,,,/,,,******/*//*///*////**/*********/*//,,**,,,****//////((#///**//******,**((((((/(/**,.........,,,,......................,,..,**//*//,,*,..*/(/((//(**/#*,/*((////*//*,.,*
    *,(*,.................***,#/,,,*/**,*,****//////*/****//,,.,,,***,.....,,***((#((///(////((/**//,/((//((#((#(//***,...,*,.,,,.........,,......,.*,,,,,.,,,******,*,........,*.,,,***,,*/*/(/(**//,,,*,
    ../*/.................*..,,,,,,,,,**,,***///*//(//*****,**,,,,,**,,..,,,,****/////*/(*//(####((#(##((###((#((////,*,.,,,,,..........,..*,,,.,,*,,,,.,,,,*****,,,,..,..........,,/***/,//(/////((*,,,* 
    ,/%**/.....,......,........,,,,.*,,**/**,****/((///*//**,**,**,,,,,,,,,*,.***/,**//(((/(#((((((##%%%%%#%((/(/*/***,,,...........,....,,*,,*,,,..,,.,,,,*,**..,,,............,,,,,**/*/(///(/////*..* 
    */(**,......,........,......,,*,.,,,,*/******///*/((///***,,****,*****,**,,*/,******//(((((####(#%%&%%%%#(((///(/*//,,.,.,,,,,......,,,,,(#((%,,/,*,,,*/,,.,,.,,.........,,,,,,,,*(//(//*////////**  
    //#//,.....*.,(............,,,,,*,,**,***********/((///*****,***,*/*////**(*,,,**/**//((###%%%###%%%%%####(#(////*,**,,,,,,,,,,,,,,*.,*/&%####(/((/*((*,,,,,.,,....,..,,,,**,,**//*//**////////*  
    ,/%/(*,.,............,,....,,,,,,,,,***,*,,,,,****///(/*//*******///(((((///*****//(((###(%(#%%###%%#######&#((((((##(/*/*,*,,*,,,,,*//(#((((%(#%(//***,,,,,,.,...,...,,*,/(###((///(///(/##/(,   
     (*/#(,...,...,...,...,,...,,*,.,,*(,,*,,*,,,/(*,////////***(//(((((//(##((((((/(//(((((#####&###################%#%###(#(#(*/*,,,,,*((#((((((((/(#/(((*,,,,.,,.....,...,,*,/(###((///(///(/##/(,   
      (/(%(*,,**..,..,...,....,.,*,,/////*,,*,,,,/***/(/*//**/,**(##%#(#((###((#((((((((((###%######(####%##%###%##%%%%%%%%%%(((****/*(/((((#((#(((((///**//,/.,,,,,..,..*****/#(%%#/(##/(/////////    
       ///(//***#,,,.,.,,*,,.....,.,****//,...,,***,*///////(***,**/((###((((###%###((#(((((#####%############%%%##%&&%%&%#((//***/*****/(((((((###%#((((//*,/*,..,.....,,****/((##(/(////(///(///*     
        (((((//**,,,***/**/*,.,..,,,,,**/,,,,.,,,,,,*,**/((/*,*,.,**///((((#########(((#########%%%%%%%#%%#%%####%%%&&%%%%#((((//////*//((((((((##%&##%%/*(//((/,,,*,,,,,**,****/////(//////(//(/(      
        .##/(/(/*,*//*///////,,,......**,,....,,,,,,,*,*,*/#*/,*,,,**(//((((####(((((#(((#%(%#(##%%%&%%%###%%######%%%%%%%%####((/(((/////(//(#((#%%##(%#%#%%/*((**,,*,,,******/*/(////(////*(/////       
          ##((//*///*//*///(/*/,,.,...,,*,*.,...,,,,,,*,*,*/#*/,*,,,**(//((((####(((((#(((#%(%#(##%%%&%%%###%%######%%%%%%%%####((/(((/////(//(#((#%%##(%#%#%%/*((**,,*,,,******/*/(////(////*(/////       
          ##((/(/////(///(*/*,.*(,.,....,,,#/**(*,*,,******/((,,,,,**(//((((((##(((((((#(##(((%%###########%%%&&%%%&%%%%%#%%%%%%&##(##((((/*****/**/(##((/(/#((((**(#(******//****/****////(**         
           ##((/(/////(///(*/*,.*(,.,....,,,#/**(*,*,,******/((,,,,,**(//((((((##(((((((#(##(((%%###########%%%&&%%%&%%%%%#%%%%%%&##(##((((/*****/**/(##((/(/#((((**(#(******//****/****////(**         
            %%(#/////(##(/*//(/,./,,,/*,.,,//*(((*,,,****,,,/**,,,,,,*******(#((#((#((((##((####(((((##%#%%%##%%##%%##%%%%&&&&%%%%####/((/********//(&#%#%&#(/(#(/*///*****,**/*/**//***////**          
             %###%(/((((/*,*.....,,,,.,***,,/((//*,,*,,,,,,,,*,*,,,***/*/#**((#%((###((((((##((%######%#####%##%%%###%%%%&&&&&%&&%%#(//************(#%%#//*#((//********##((((/**///////*//            
              .##%(#((((/,,.........**(///***//**,,*,,****,,,***,**,,,,,,**(((#########((((##(######%%%%#%%%###%#####%#%%%%&%%&&&&&%#(/(//***/******(##(#(*((/((//***,*/(#(((//////*////*(/             
                #(((##(*%/*,,.,.......*(///*///***#(/*,***,*,,,...,,*,,,/(##(((###%###(###&%&%%##(###(#########((###%%#%#%#%%%%%&%%%##((/(/******,**/(((((#(/**/(/**////(#((*(((//(/**///,              
                  #((#%(#(/,,,,,......,*/**,*,,*/***/******,,,,,,,,,,,**(#(((%#####((((##%###%%(((((#######(#########%##%%%%%%%#%%%%%%/////#/(#%##(//(##(/#(((((/((((((/(%(#((((/****/                
                   /((####///,*,,,..,.,,,,**,*,,*//*****,,,,*/,,,,,,,,**///#(&%####((((####((##(((((######%##%%#%##%#((##%%%%#%%%%%%%%%#((((###%%##(/((##(#(#%#(#%#((((#%#(##((((/****                  
                     /(((#&%#(/*/,,,,,,,/****(/,,,*******,,,,,,,,,,,,,,***/*/(###%##(#####%####((#####%#%%%%%%%%#(##########%%%%&&%%#######%####((((#%###%%#%##%#%%%###(%%#((%((////                    
                       (((((%###(/***(**//(//*(,**,,/***,,,,,,,,,,,,,,*,***/###%##((##%%%%%%######%%%%%%%%%%%%######(###%##%&&&%%%#%%#%%%&%#%#(####(##%%%%%%%%%%%%%%#%%%#(#&((///*.                     
                         #/(((/((*(/////(//(/,,*/(///*((/*/*****//**//*(/**(###%%#%%%%%#&%%%%###%%%%%&%%%#%(#((#####%###%%%%%%%##%#%%%%%########(###%#%#(##%%%&&%%%%%%###%(////*                        
                           ///(((/**//((/((#*/,,***//*/#%%#(#/(((****######%%%%%%%&%%%&%%&&%%%##%%%%%%%%###(#(#(###%&&%###(#%%#######%%##(####%###########%%%&%%%%&&#(((///***                          
                              //(/((***(((//((***((***/(#%%&&#%%#%#(%#%%%&%&&&&&%%%%&&%%%&%&%%%%%##%##(########(#%&%%%%######%%%###(##(##(######%#%####%%%%%%%%%##///////***                            
                                /,/%(((/(/##((((%#(*(###((%##%%%%%#%%#%&%%&&&&&@@&&&&%%%%%%%%%%%%%#%##%##%%##%%%&%%####%#%%#%%##(#(####((###############%#%%####(///****                               
                                   ////(((#(#((#(((/##%(%###%##%%##%%%%&&&&&&%%&&&&&%%%&%%%%%&&&#%##%%%%###%%%%##%####(###%###(####(#(##########(##(#(#%#%((/(////***,                                  
                                      /*////((###(##(##((((##%%%%%&%&%&&&&&&&&&&&&&&&%&%&%%%%%%%###%&&%#%%######%%########(###(#%%%##(####(#####%%####%((((/////***.                                    
                                         //*//(//((#((#((#%#%%#%%%%%&&&%%%%%%&&&&&&&&&&&&&&&&&&%%%%%##(####((##%######%#%%%%%##(((####%%###%%%#%####(#(((/(///*,                                        
                                            ./////(((##(#((####%%%%%%%%#&&&&&%%%%&&&&&&%%%&%%%%%%%&%%##%%%%%%%%#((####%##(#(###((##%#######%%%####((////((/**                                           
                                                ***#/(((#((##((%#%%%%%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%####((##((((((####((#####%%%%%##%%%%%##(#(///#((/*,,                                               
                                                    ,**(((/((((###%#%%%%%&&&&%%&&&%&&&&&&%%&%%%%#%%%%#######((#(((((#(#(((####(######(##(((////////*,                                                   
                                                         *(((#(((###%%#%%%%%&&%%%%%%%%%%%%#&&%%%%%###%%%#((###(((####((#(###(#######(((((((/////                                                        
                                                               ((/(####(#%%%%%%#%%%%%%%%%%##%%%%%#%######(########%##((((((((###//(((/////                                                              
                                                                     .(((##(##%%%#%%%%%%%%%%%#%%##%%%%#((####(((((((((((/((((((////,                                                                    
                                                                              */(%%%%%%%%%##%##########(/(((/(((((////////.                                                                             
]]

-- Moon Phases
local MoonPhase = {
  NEW = "New Moon",
  WAXING_CRESCENT = "Waxing Crescent",
  FIRST_QUARTER = "First Quarter",
  WAXING_GIBBOUS = "Waxing Gibbous",
  FULL = "Full Moon",
  WANING_GIBBOUS = "Waning Gibbous",
  LAST_QUARTER = "Last Quarter",
  WANING_CRESCENT = "Waning Crescent",
}

-- Languages
local Language = {
  ENGLISH = 1,
  CHINESE = 2,
  FRENCH = 3,
  JAPANESE = 4,
  SPANISH = 5,
}

local LANGUAGE_NAMES = {
  [Language.ENGLISH] = "English",
  [Language.CHINESE] = "中文",
  [Language.FRENCH] = "Français",
  [Language.JAPANESE] = "日本語",
  [Language.SPANISH] = "Español",
}

-- Lunar Features with multilingual names
local LUNAR_FEATURES = {
  {
    names = {
      "Oceanus Procellarum",
      "风暴洋",
      "Océan des Tempêtes",
      "嵐の大洋",
      "Océano de las Tormentas",
    },
    lat = 18.4,
    lon = -57.4,
  },
  {
    names = {
      "Mare Imbrium",
      "雨海",
      "Mer des Pluies",
      "雨の海",
      "Mar de las Lluvias",
    },
    lat = 32.8,
    lon = -25.6,
  },
  {
    names = {
      "Mare Serenitatis",
      "澄海",
      "Mer de la Sérénité",
      "晴れの海",
      "Mar de la Serenidad",
    },
    lat = 20.0,
    lon = 13.5,
  },
  {
    names = {
      "Mare Tranquillitatis",
      "静海",
      "Mer de la Tranquillité",
      "静かの海",
      "Mar de la Tranquilidad",
    },
    lat = 3.5,
    lon = 22.4,
  },
  {
    names = {
      "Mare Crisium",
      "危海",
      "Mer des Crises",
      "危難の海",
      "Mar de las Crisis",
    },
    lat = 17.0,
    lon = 58.5,
  },
  {
    names = { "Tycho", "第谷", "Tycho", "ティコ", "Tycho" },
    lat = -43.3,
    lon = -11.2,
  },
  {
    names = {
      "Copernicus",
      "哥白尼",
      "Copernic",
      "コペルニクス",
      "Copérnico",
    },
    lat = 9.6,
    lon = -20.1,
  },
  {
    names = { "Kepler", "开普勒", "Kepler", "ケプラー", "Kepler" },
    lat = 8.1,
    lon = -38.0,
  },
  {
    names = {
      "Aristarchus",
      "阿里斯塔克斯",
      "Aristarque",
      "アリスタルコス",
      "Aristarco",
    },
    lat = 23.7,
    lon = -47.4,
  },
  {
    names = { "Plato", "柏拉图", "Platon", "プラトン", "Platón" },
    lat = 51.6,
    lon = -9.3,
  },
}

local function detect_hemisphere_from_timezone()
  local tz = os.getenv "TZ" or ""

  -- Known southern hemisphere patterns
  local southern_patterns = {
    "Australia",
    "Sydney",
    "Melbourne",
    "Brisbane",
    "Perth",
    "Adelaide",
    "New_Zealand",
    "Auckland",
    "Wellington",
    "Antarctica",
    "Pacific/Auckland",
    "Pacific/Fiji",
    "Pacific/Tongatapu",
    "Indian/Mauritius",
    "Indian/Reunion",
    "Africa/Johannesburg",
    "Africa/Windhoek",
    "Africa/Maputo",
    "America/Argentina",
    "America/Santiago",
    "America/Montevideo",
    "America/Sao_Paulo",
    "America/Lima",
    "America/Bogota",
    "Atlantic/South_Georgia",
  }

  for _, pattern in ipairs(southern_patterns) do
    if tz:find(pattern, 1, true) then
      return "south"
    end
  end
  return "north"
end

-- Calculate moon phase for a given timestamp
local function calculate_moon_phase(timestamp)
  local diff = timestamp - KNOWN_NEW_MOON_SEC
  local days_since_known_new_moon = diff / 86400.0

  local age = days_since_known_new_moon % SYNODIC_MONTH
  if age < 0 then
    age = age + SYNODIC_MONTH
  end

  local phase_fraction = age / SYNODIC_MONTH
  local segment = math.floor((phase_fraction * 8.0) + 0.5) % 8

  local phase_name
  if segment == 0 then
    phase_name = MoonPhase.NEW
  elseif segment == 1 then
    phase_name = MoonPhase.WAXING_CRESCENT
  elseif segment == 2 then
    phase_name = MoonPhase.FIRST_QUARTER
  elseif segment == 3 then
    phase_name = MoonPhase.WAXING_GIBBOUS
  elseif segment == 4 then
    phase_name = MoonPhase.FULL
  elseif segment == 5 then
    phase_name = MoonPhase.WANING_GIBBOUS
  elseif segment == 6 then
    phase_name = MoonPhase.LAST_QUARTER
  else
    phase_name = MoonPhase.WANING_CRESCENT
  end

  local angle = phase_fraction * 2.0 * math.pi
  local illumination = 0.5 * (1.0 - math.cos(angle))

  return {
    phase = phase_name,
    phase_fraction = phase_fraction,
    age_days = age,
    illumination = illumination * 100.0,
  }
end

-- Parse the moon art into a 2D grid
local function parse_moon_art()
  local lines = {}
  for line in MOON_ART_RAW:gmatch "[^\r\n]+" do
    if #line > 0 then
      local chars = {}
      for char in line:gmatch "." do
        table.insert(chars, char)
      end
      table.insert(lines, chars)
    end
  end
  return lines
end

-- Calculate bounding box of non-whitespace characters
local function calculate_bounding_box(art_lines)
  local min_x, max_x = math.huge, 0
  local min_y, max_y = math.huge, 0

  for y, line in ipairs(art_lines) do
    for x, char in ipairs(line) do
      if char ~= " " then
        min_x = math.min(min_x, x)
        max_x = math.max(max_x, x)
        min_y = math.min(min_y, y)
        max_y = math.max(max_y, y)
      end
    end
  end

  if min_x > max_x or min_y > max_y then
    return nil
  end

  return {
    min_x = min_x,
    max_x = max_x,
    min_y = min_y,
    max_y = max_y,
    width = max_x - min_x + 1,
    height = max_y - min_y + 1,
  }
end

-- Render the moon with proper 3D illumination
local function render_moon(
  art_lines,
  bbox,
  width,
  height,
  phase_fraction,
  show_labels,
  language,
  hemisphere
)
  if not bbox then
    return
  end

  local crop_w = bbox.width
  local crop_h = bbox.height
  local art_aspect = crop_w / crop_h

  -- Calculate drawing dimensions
  local draw_w, draw_h
  if width / height < art_aspect then
    draw_w = width
    draw_h = width / art_aspect
  else
    draw_w = height * art_aspect
    draw_h = height
  end

  -- Center the drawing
  local start_x = (width - draw_w) / 2.0
  local start_y = (height - draw_h) / 2.0

  -- Sun angle for illumination
  local angle = phase_fraction * 2.0 * math.pi
  local sun_x = math.sin(angle)
  local sun_z = -math.cos(angle)

  -- Flip for Southern hemisphere
  local hemisphere_flip = (hemisphere == "south") and -1 or 1

  -- Render each cell
  local lines = {}
  for y = 1, height do
    local line = {}
    for x = 1, width do
      -- Normalized coordinates relative to the drawn moon box
      local ny = (y - start_y) / draw_h
      local nx = (x - start_x) / draw_w

      if ny >= 0 and ny < 1 and nx >= 0 and nx < 1 then
        -- Sample from source art
        local src_y = math.floor(bbox.min_y + ny * crop_h)
        local src_x = math.floor(bbox.min_x + nx * crop_w)

        local char = " "
        if src_y >= 1 and src_y <= #art_lines then
          local row = art_lines[src_y]
          if src_x >= 1 and src_x <= #row then
            char = row[src_x]
          end
        end

        -- Circular mask and spherical projection
        local dx = nx - 0.5
        local dy = ny - 0.5
        local dist_sq = dx * dx + dy * dy

        if dist_sq <= 0.25 then
          -- Map to sphere coordinates (with hemisphere flip)
          local u = dx * 2.0 * hemisphere_flip
          local v = dy * 2.0
          local z_sq = 1.0 - u * u - v * v

          if z_sq >= 0 then
            local z = math.sqrt(z_sq)

            -- Calculate illumination
            local intensity = u * sun_x + z * sun_z

            table.insert(line, { char = char, lit = intensity > 0 })
          else
            table.insert(line, { char = " ", lit = false })
          end
        else
          table.insert(line, { char = " ", lit = false })
        end
      else
        table.insert(line, { char = " ", lit = false })
      end
    end
    table.insert(lines, line)
  end

  -- Add labels if enabled
  local labels = {}
  if show_labels then
    for _, feature in ipairs(LUNAR_FEATURES) do
      local rad_lat = math.rad(feature.lat)
      local rad_lon = math.rad(feature.lon)

      -- Orthographic projection (with hemisphere flip)
      local u = math.cos(rad_lat) * math.sin(rad_lon) * hemisphere_flip
      local v = math.sin(rad_lat)

      -- Check if feature is on visible hemisphere (z >= 0)
      local z = math.cos(rad_lat) * math.cos(rad_lon)
      if z >= 0 then
        -- Project to screen UV (0..1)
        local scale = 0.45
        local nx = 0.5 + u * scale
        local ny = 0.5 - v * scale

        local term_x = math.floor(start_x + nx * draw_w + 0.5)
        local term_y = math.floor(start_y + ny * draw_h + 0.5)

        if
          term_x >= 1
          and term_x <= width
          and term_y >= 1
          and term_y <= height
        then
          table.insert(labels, {
            x = term_x,
            y = term_y,
            name = feature.names[language],
          })
        end
      end
    end
  end

  return lines, labels
end

-- Setup highlights
local function setup_highlights()
  vim.api.nvim_set_hl(0, "MoonLit", { fg = "#FFFF00", bold = true })
  vim.api.nvim_set_hl(0, "MoonShadow", { fg = "#555555" })
  vim.api.nvim_set_hl(0, "MoonLabel", { fg = "#00FFFF", bold = true })
  vim.api.nvim_set_hl(0, "MoonMarker", { fg = "#FF0000", bold = true })
  vim.api.nvim_set_hl(0, "MoonInfo", { fg = "#AAAAAA" })
  vim.api.nvim_set_hl(0, "MoonTitle", { fg = "#00FFFF", bold = true })
end

local function get_hemisphere()
  local co = assert(coroutine.running())
  vim.system(
    { "curl", "-s", "http://ip-api.com/json/?fields=lat" },
    { text = true },
    function(obj)
      if obj.code == 0 then
        local ok, res = pcall(vim.json.decode, obj.stdout)
        coroutine.resume(co, ok and res.lat)
      end
    end
  )
  local lat = coroutine.yield()
  if lat ~= nil then
    return lat >= 0 and "north" or "south"
  end
  return detect_hemisphere_from_timezone()
end

-- Create and display the moon viewer
function M.show(date_timestamp)
  setup_highlights()
  coroutine.wrap(function()
    local hemisphere = get_hemisphere()
    vim.schedule(function()
      local art_lines = parse_moon_art()
      local bbox = calculate_bounding_box(art_lines)

      local timestamp = date_timestamp or os.time()
      local show_labels = false
      local show_info = true
      local language = Language.ENGLISH

      local buf = vim.api.nvim_create_buf(false, true)
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].modifiable = false

      -- Calculate window size
      local ui = vim.api.nvim_list_uis()[1]
      local win_width = math.floor(ui.width * 0.9)
      local win_height = math.floor(ui.height * 0.9)

      -- Create floating window
      local win_opts = {
        relative = "editor",
        width = win_width,
        height = win_height,
        col = math.floor((ui.width - win_width) / 2),
        row = math.floor((ui.height - win_height) / 2),
        style = "minimal",
        border = "rounded",
        title = " 🌙 Moon Phase Viewer ",
        title_pos = "center",
      }
      local win = vim.api.nvim_open_win(buf, true, win_opts)

      local render = function()
        local moon_status = calculate_moon_phase(timestamp)

        -- Calculate render area
        local info_height = show_info and 9 or 0
        local moon_height = win_height - info_height - 2

        local moon_lines, labels = render_moon(
          art_lines,
          bbox,
          win_width - 2,
          moon_height,
          moon_status.phase_fraction,
          show_labels,
          language,
          hemisphere
        )

        local output_lines = {}
        local ns_id = vim.api.nvim_create_namespace "moon_phase"

        for _, line in ipairs(moon_lines) do
          local text = {}
          for _, cell in ipairs(line) do
            table.insert(text, cell.char)
          end
          table.insert(output_lines, table.concat(text))
        end

        if show_info then
          table.insert(output_lines, string.rep("─", win_width))
          local date_str = os.date("%Y-%m-%d", timestamp)
          table.insert(output_lines, string.format("  Date: %s", date_str))
          table.insert(
            output_lines,
            string.format("  Phase: %s", moon_status.phase)
          )
          table.insert(
            output_lines,
            string.format("  Age: %.1f days", moon_status.age_days)
          )
          table.insert(
            output_lines,
            string.format("  Illumination: %.1f%%", moon_status.illumination)
          )
          table.insert(
            output_lines,
            string.format("  Language: %s", LANGUAGE_NAMES[language])
          )
          local hemi_icon = hemisphere == "north" and "↑" or "↓"
          table.insert(
            output_lines,
            string.format(
              "  Hemisphere: %s %s",
              hemisphere:sub(1, 1):upper() .. hemisphere:sub(2),
              hemi_icon
            )
          )
          table.insert(output_lines, "")
          table.insert(
            output_lines,
            "  <h/l> date  <j> labels  <k> language  <m> hemisphere  <i> info  <q> quit"
          )
        end

        vim.bo[buf].modifiable = true
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output_lines)
        vim.bo[buf].modifiable = false

        vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)

        for y, line in ipairs(moon_lines) do
          for x, cell in ipairs(line) do
            if cell.char ~= " " then
              local hl_group = cell.lit and "MoonLit" or "MoonShadow"
              vim.hl.range(buf, ns_id, hl_group, { y - 1, x - 1 }, { y - 1, x })
            end
          end
        end

        for _, label in ipairs(labels) do
          if
            label.y > 0
            and label.y <= #moon_lines
            and label.x > 0
            and label.x <= win_width
          then
            local line_idx = label.y - 1
            local col = label.x - 1

            vim.api.nvim_buf_set_extmark(buf, ns_id, line_idx, col, {
              virt_text = { { "x", "MoonMarker" }, { label.name, "MoonLabel" } },
              virt_text_pos = "overlay",
              hl_mode = "combine",
            })
          end
        end
        if show_info then
          for i = #moon_lines + 2, #output_lines do
            vim.hl.range(buf, ns_id, "MoonInfo", { i - 1, 0 }, { i - 1, -1 })
          end
        end
      end
      render()

      vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(win, true)
      end, { buffer = buf })

      local function set_keymap(key, action)
        vim.api.nvim_buf_set_keymap(buf, "n", key, "", {
          noremap = true,
          silent = true,
          callback = function()
            action()
            render()
          end,
        })
      end

      set_keymap("h", function()
        timestamp = timestamp - 86400
      end)

      set_keymap("l", function()
        timestamp = timestamp + 86400
      end)

      set_keymap("j", function()
        show_labels = not show_labels
      end)

      set_keymap("k", function()
        language = (language % 5) + 1
      end)

      set_keymap("m", function()
        hemisphere = (hemisphere == "north") and "south" or "north"
      end)

      set_keymap("i", function()
        show_info = not show_info
      end)

      vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", {
        noremap = true,
        silent = true,
        callback = function()
          vim.api.nvim_win_close(win, true)
        end,
      })
    end)
  end)()
end

function M.date(date_str)
  local year, month, day = date_str:match "(%d+)-(%d+)-(%d+)"
  if not year then
    vim.notify("Invalid date format. Use YYYY-MM-DD", vim.log.levels.ERROR)
    return
  end

  local timestamp = os.time {
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = 12,
  }

  M.show(timestamp)
end

return M
