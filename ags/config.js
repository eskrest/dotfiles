import mpvWidget from './widgets/mpv.js';
import workspacesWidget from './widgets/workspaces.js';
import audioWidget from './widgets/audio.js';
import timeWidget from './widgets/datetime.js';
import batteryWidget from './widgets/battery.js';
import brightnessWidget from './widgets/brightness.js';
import networkWidget from './widgets/iwd.js';
import languageWidget from './widgets/keyboard.js';
import calendarWidget from './widgets/calendar.js';
import { NotificationPopups } from "./widgets/notificationPopups.js"
import mediaWidget from './widgets/media.js';

const init = async () => {

    // styles section
    const sass = `${App.configDir}/styles.sass`;
    const css = `${App.configDir}/tmp/styles.css`;
    const compileStyles = () => {
        Utils.exec(`sassc ${sass} ${css}`);
        return css;
    };
    compileStyles();

    Utils.monitorFile(sass, () => {
        compileStyles();
        App.resetCss();
        App.applyCss(css);
    });
    // end styles section

    const Bar = (/** @type {number} */ monitor) =>
        Widget.Window({
            monitor,
            name: `bar${monitor}`,
            anchor: ["bottom", "left", "right"],
            margins: [0, 20, 10, 20],
            exclusivity: "exclusive",
            child: Widget.CenterBox({
                start_widget: workspacesWidget,
                end_widget: Widget.Box({
                    hpack: "end",
                    children: [
                        mpvWidget,
                        audioWidget,
                        languageWidget,
                        networkWidget,
                        brightnessWidget,
                        batteryWidget,
                        timeWidget,
                    ]
                })
            }),
        });

    const Calendar = (/** @type {number} */ monitor) =>
        Widget.Window({
            visible: false,
            monitor,
            name: `calendar${monitor}`,
            anchor: ["bottom", "right"],
            margins: [0, 20, 10, 20],
            child: Widget.CenterBox({
                end_widget: Widget.Box({
                    hpack: "end",
                    children: [
                        calendarWidget,
                    ]
                })
            }),
        });

    const MediaPlayer = (/** @type {number} */ monitor) =>
        Widget.Window({
            visible: false,
            monitor,
            name: `media${monitor}`,
            anchor: ["left", "bottom", "right"],
            margins: [0, 20, 10, 20],
            child: Widget.CenterBox({
                end_widget: Widget.Box({
                    hpack: "center",
                    children: [
                        mediaWidget,
                    ]
                })
            }),
        });

    App.config({
        style: css,
        windows: [
            Bar(0),
            Calendar(0),
            NotificationPopups(),
            MediaPlayer(0),
        ],
    });
};
init();
