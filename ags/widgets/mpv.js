const mpris = await Service.import('mpris')
const mpv = Variable("", {
    poll: [
        1000,
        async () => {
            // console.log(mpris)
            const output = await Utils.execAsync("sh -c '$HOME/.config/scripts/mpv/waybar_mpv.sh 2> /dev/null'");
            const text = JSON.parse(output).text;
            // return `${text}`;
            // shorten the text if it's too long
            return text
        },
    ],
});

/** @param {import('types/service/mpris').MprisPlayer} player */
const Player = player => Widget.EventBox({
    on_primary_click: () => {
        Utils.execAsync('ags --toggle-window media0');
    },
    // on_primary_click: () => player.playPause(),
    // on_secondary_click: () => player.next(),
    // on_middle_click: () => player.previous(),
    child: Widget.Label().hook(player, label => {
        const { track_artists, track_title, can_play } = player;
        label.class_name = "mpv";
        label.label = `${track_title} - ${track_artists.join(', ')}`;
        label.max_width_chars = 38;
        label.truncate = "end";
        label.visible = can_play;
    }),
})

const players = Widget.Box({
    children: mpris.bind('players').as(p => p.map(Player))
})

const mpvWidget = Widget.Box({
    // on_primary_click: () => {
    //     Utils.execAsync("sh -c '$HOME/.config/scripts/mpv/play-pause.sh 2> /dev/null'")
    // },
    // on_secondary_click: () => {
    //     Utils.execAsync("sh -c '$HOME/.config/scripts/mpv/next.sh 2> /dev/null'")
    // },
    // on_middle_click: () => {
    //     Utils.execAsync("sh -c '$HOME/.config/scripts/mpv/prev.sh 2> /dev/null'")
    // },
    // visible: mpv.bind().as(v => v.length > 0),
    // child: Widget.Label({
    //     className: "mpv",
    //     label: mpv.bind(),
    //     max_width_chars: 38,
    //     truncate: "end",
    //     wrap: true,
    // })
    child: players,
})

export default mpvWidget;
