const hyprland = await Service.import("hyprland");
// https://github.com/Aylur/ags/issues/414#issuecomment-2155988751
const getKeyboardLayout = () => {
    const devices = Utils.exec("sh -c 'hyprctl devices -j | jq .keyboards'");
    const keyboards = JSON.parse(devices);
    const mainKb = keyboards.find(({ main }) => main === true);
    return mainKb?.active_keymap ?? "??";
};

const layout = Utils.watch(
    getKeyboardLayout(),
    hyprland,
    "keyboard-layout",
    () => getKeyboardLayout(),
);

const languageWidget = Widget.Label({
    className: "language",
    label: layout.as(
        (layout) =>
            ({
                "English (US)": "us",
                "Russian": "ru",
            })[layout] ?? layout,
    ),
});

export default languageWidget;
