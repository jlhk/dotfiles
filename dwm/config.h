/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>  // for the media keys

/* appearance */
#define NUMCOLORS         3             // need at least 3
static const char colors[NUMCOLORS][ColLast][8] = {
   // border   foreground  background
    { "#073642", "#b58900", "#002b36"  }, // 01 = default   (0)
    { "#073642", "#b58900", "#073642"  }, // 02 = selected  (0)

    { "#cc6666", "#b58900", "#718c00"  }, // 03 = okay      (1)
    { "#cc6666", "#b58900", "#eab700"  }, // 04 = attention (2)
    { "#000000", "#b58900", "#c82829"  }, // 05 = critical  (3)

    { "#000000", "#718c00", "#1d1f21" },  // 06 = 0-1
    { "#000000", "#eab700", "#1d1f21" },  // 07 = 0-2
    { "#000000", "#c82829", "#1d1f21" },  // 08 = 0-3
    { "#000000", "#eab700", "#718c00" },  // 09 = 1-2
    { "#000000", "#c82829", "#718c00" },  // 0A = 1-3
    { "#000000", "#718c00", "#eab700" },  // 0B = 2-1
    { "#000000", "#c82829", "#eab700" },  // 0C = 2-3
    { "#000000", "#718c00", "#c82829" },  // 0D = 3-1
    { "#000000", "#eab700", "#c82829" },  // 0E = 3-2
};

static const char font[]            = "Terminus:size=9";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 33;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };


static const Rule rules[] = {
    /* xprop(1):
       WM_CLASS(STRING) = instance, class
       WM_NAME(STRING) = title

    	class           instance   title    tags mask     isfloating   monitor */
    { "st-256color",    NULL,       NULL,     1 << 0,        0,           1 },
    { "Firefox",        NULL,       NULL,     1 << 1,        0,           1 },
    { "VirtualBox",     NULL,       NULL,     1 << 5,        0,          -1 },
    { "Sky",            NULL,       NULL,     1 << 7,        1,          -1 },
    { "Evolution",      NULL,       NULL,     1 << 8,        0,          -1 },
    { "Spotify",        NULL,       NULL,     1 << 9,        0,          -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },    /* first entry is default */
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/bash", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG],"-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *volup[]    = { "amixer", "-q", "sset", "Master", "5%+", "unmute", NULL };
static const char *voldown[]  = { "amixer", "-q", "sset", "Master", "5%-", "unmute", NULL };
static const char *volmute[]  = { "amixer", "-q", "sset", "Master", "toggle", NULL };
static const char *play[]     = { "playerctl", "play-pause", NULL };
static const char *next[]     = { "playerctl", "next",   NULL };
static const char *prev[]     = { "playerctl", "previous",   NULL };
static const char *stop[]     = { "playerctl", "pause",   NULL };
static const char *lightinc[]     = { "xbacklight", "-inc", "10" };
static const char *lightdec[]     = { "xbacklight", "-dec", "10" };
static const char *lock[]     = { "slock", NULL };


static Key keys[] = {
    /* modifier           key                       function        argument */
    { MODKEY,             XK_p,                     spawn,          {.v = dmenucmd } },
    { MODKEY|ShiftMask,   XK_Return,                spawn,          {.v = termcmd } },
    { MODKEY,             XK_b,                     togglebar,      {0} },
    { MODKEY,             XK_j,                     focusstack,     {.i = +1 } },
    { MODKEY,             XK_k,                     focusstack,     {.i = -1 } },
    { MODKEY,             XK_i,                     incnmaster,     {.i = +1 } },
    { MODKEY,             XK_d,                     incnmaster,     {.i = -1 } },
    { MODKEY,             XK_h,                     setmfact,       {.f = -0.05} },
    { MODKEY,             XK_l,                     setmfact,       {.f = +0.05} },
    { MODKEY,             XK_Return,                zoom,           {0} },
    { 0,                  XF86XK_AudioRaiseVolume,  spawn,          {.v = volup } },
    { 0,                  XF86XK_AudioLowerVolume,  spawn,          {.v = voldown } },
    { 0,                  XF86XK_AudioMute,         spawn,          {.v = volmute } },
    { 0,                  XF86XK_AudioPlay,         spawn,          {.v = play } },
    { 0,                  XF86XK_AudioNext,         spawn,          {.v = next } },
    { 0,                  XF86XK_AudioPrev,         spawn,          {.v = prev } },
    { 0,                  XF86XK_AudioStop,         spawn,          {.v = stop } },
    { 0,                  XF86XK_MonBrightnessDown, spawn,          {.v = lightdec } },
    { 0,                  XF86XK_MonBrightnessUp,   spawn,          {.v = lightinc } },
    { MODKEY,             XK_Tab,                   view,           {0} },
    { MODKEY|ShiftMask,   XK_c,                     killclient,     {0} },
    { MODKEY,             XK_t,                     setlayout,      {.v = &layouts[0]} },
    { MODKEY,             XK_f,                     setlayout,      {.v = &layouts[1]} },
    { MODKEY,             XK_m,                     setlayout,      {.v = &layouts[2]} },
    { MODKEY,             XK_space,                 setlayout,      {0} },
    { MODKEY|ShiftMask,   XK_space,                 togglefloating, {0} },
    { MODKEY,             XK_0,                     view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,   XK_0,                     tag,            {.ui = ~0 } },
    { MODKEY,             XK_comma,                 focusmon,       {.i = -1 } },
    { MODKEY,             XK_period,                focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,   XK_comma,                 tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,   XK_period,                tagmon,         {.i = +1 } },
    TAGKEYS(              XK_1,                     0)
    TAGKEYS(              XK_2,                     1)
    TAGKEYS(              XK_3,                     2)
    TAGKEYS(              XK_4,                     3)
    TAGKEYS(              XK_5,                     4)
    TAGKEYS(              XK_6,                     5)
    TAGKEYS(              XK_7,                     6)
    TAGKEYS(              XK_8,                     7)
    TAGKEYS(              XK_9,                     8)
    { MODKEY|ShiftMask,   XK_q,                     quit,           {0} },
    { MODKEY|ShiftMask,   XK_l,                     spawn,           {.v = lock } },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

