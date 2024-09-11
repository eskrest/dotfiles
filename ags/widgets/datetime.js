const time = Variable("", {
    poll: [
        1000,
        () => {
            const now = new Date();
            const hours = `0${now.getHours()}`.slice(-2);
            const minutes = `0${now.getMinutes()}`.slice(-2);
            return `${now.toLocaleDateString("en-EN", { weekday: "short", year: "numeric", month: "short", day: "numeric" })}, ${hours}:${minutes}`;
        },
    ],
});
const timeWidget = Widget.EventBox({
    on_primary_click: () => {
        Utils.execAsync('ags --toggle-window calendar0');
    },
    child: Widget.Label({
        className: "datetime",
        label: time.bind(),
    }),
})

export default timeWidget;
