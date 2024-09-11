const battery = await Service.import('battery')

const batteryLabel = Widget.Label({
    label: battery.bind('percent').as(p => `${p}% `),
})
const batteryIcon = Widget.Icon({
    icon: battery.bind('icon_name').as(i => {
        return i
    })
});

const batteryWidget = Widget.EventBox({
    // on_primary_click: () => {
    //     console.log('click')
    // },
    child: Widget.Box({
        className: "battery",
        children: [
            batteryLabel,
            batteryIcon,
        ],
        visible: battery.bind('available'),
    })
})

export default batteryWidget;
