let visibilityTimeout = null
const calendarWidget = Widget.EventBox({
    on_hover: () => {
        !!visibilityTimeout && clearTimeout(visibilityTimeout)
        visibilityTimeout = setTimeout(() => {
            Utils.execAsync('ags --toggle-window calendar0')
        }, 1000)
    },
    child: Widget.Calendar({
        className: "calendar",
        showDayNames: true,
        // showDetails: true,
        showHeading: true,
        // showWeekNumbers: true,
        // detail: (self, y, m, d) => {
        //     return `<span color="white">${y}. ${m}. ${d}.</span>`
        // },
        // onDaySelected: ({ date: [y, m, d] }) => {
        //     print(`${y}. ${m}. ${d}.`)
        // },
    })
})

export default calendarWidget;
