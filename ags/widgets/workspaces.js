const hyprland = await Service.import("hyprland");

const workspace_icons = [ " ", " ", " ", " ", " ", "󰞷 ", "󰞷 ", "󰞷 ", "󰞷 ", "󰞷 ", ]

const workspacesWidget = Widget.Box({
    children: Array.from({ length: 10 }, (_, i) => i).map((i) =>
        Widget.Label({
            attribute: i+1,
            label: workspace_icons[i],
            visible: hyprland.workspaces.some((ws) => ws.id === i),
        })
    ),

    // remove this setup hook if you want fixed number of buttons
    setup: (self) =>
        self.hook(hyprland, () =>
            self.children.forEach((btn) => {
                btn.className = `workspace ${hyprland.active.workspace.id === btn.attribute ? "active" : ""}`
                btn.visible = hyprland.workspaces.some(
                    (ws) => ws.id === btn.attribute,
                );
            }),
        ),
})

export default workspacesWidget;
