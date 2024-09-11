import brightness from '../services/brightness.js';

const brightnessIcons = ["", "", "", "", "", "", "", "", ""];
// 0-15,
// 15-25
// 25-35
// 35-45
// 45-55
// 55-70
// 70-80
// 80-90
// 90-100
const getBrightnessLabel = brightness => {
    const v = brightness * 100;
    const icon = v < 15 ? 0 : v < 25 ? 1 : v < 35 ? 2 : v < 45 ? 3 : v < 55 ? 4 : v < 70 ? 5 : v < 80 ? 6 : v < 90 ? 7 : 8;
    return `${parseInt(v)}% ${brightnessIcons[icon]}`;
}
const brightnessWidget = Widget.EventBox({
    on_scroll_up: () => {
        brightness.screen_value = Math.min(1, brightness.screen_value + 0.05);
    },
    on_scroll_down: () => {
        brightness.screen_value = Math.max(0, brightness.screen_value - 0.05);
    },
    child: Widget.Label({
        className: "brightness",
        label: brightness.bind('screen-value').as(v => {
            return getBrightnessLabel(v);
        }),
        setup: self => self.hook(brightness, (self, screenValue) => {
            self.label = `${screenValue ?? 0}`;
            self.label = getBrightnessLabel(brightness.screen_value)

        }, 'screen-changed'),
    })
});

export default brightnessWidget;
