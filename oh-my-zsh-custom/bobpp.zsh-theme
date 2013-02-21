# Setting Color
local ORANGE=$'%{[33m%}'
local GREEN=$'%{[32m%}'
local BLUE=$'%{[34m%}'
local DEFAULT=$'%{[m%}'
PROMPT=$ORANGE'(%n@%m) '$GREEN'[%~]'$BLUE' $(git_prompt_info)'$DEFAULT$'\n%(!.#.$) '

