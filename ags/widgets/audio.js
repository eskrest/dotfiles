const audio = await Service.import('audio')

const volumeWidget = Widget.EventBox({
    on_primary_click: () => {
        audio.speaker.is_muted = !audio.speaker.is_muted;
    },
    on_scroll_up: () => {
        audio.speaker.volume = Math.min(1, audio.speaker.volume + 0.05);
    },
    on_scroll_down: () => {
        audio.speaker.volume = Math.max(0, audio.speaker.volume - 0.05);
    },
    child: Widget.Box({
        children: [
            Widget.Label({
                label: audio.speaker.bind('volume').as(v => `${Math.round(v * 100)}% `),
                visible: audio.speaker.bind('is-muted').as(v => !v),
            }),
            Widget.Icon().hook(audio.speaker, self => {
                const vol = Math.round(audio.speaker.volume * 100);
                const icons = [
                    [101, 'overamplified'],
                    [67, 'high'],
                    [34, 'medium'],
                    [1, 'low'],
                    [0, 'muted'],
                ]
                let icon = icons.find(([threshold]) => threshold <= vol)?.[1];
                if (audio.speaker.is_muted) {
                    icon = 'muted';
                }

                self.icon = `audio-volume-${icon}-symbolic`;
                // self.tooltip_text = `Volume ${Math.floor(vol)}%`;
            }),
            Widget.Label({
                label: ' ',
            }),
        ],
    })
})

const microphoneWidget = Widget.EventBox({
    on_primary_click: () => {
        audio.microphone.is_muted = !audio.microphone.is_muted;
    },
    on_scroll_up: () => {
        audio.microphone.volume = Math.min(1, audio.microphone.volume + 0.05);
    },
    on_scroll_down: () => {
        audio.microphone.volume = Math.max(0, audio.microphone.volume - 0.05);
    },
    child: Widget.Box({
        children: [
            Widget.Label({
                label: audio.microphone.bind('volume').as(v => `${Math.round(v * 100)}% `),
                visible: audio.microphone.bind('is-muted').as(v => !v),
            }),
            Widget.Label().hook(audio.microphone, self => {
                const vol = Math.round(audio.microphone.volume * 100);
                let icon = ' ';
                if (audio.microphone.is_muted || vol === 0) {
                    icon = ' ';
                }
                self.label = icon;
            }),
        ]
    })
})
const audioWidget = Widget.Box({
    className: "audio",
    children: [
        volumeWidget,
        microphoneWidget,
    ],
})

export default audioWidget;
