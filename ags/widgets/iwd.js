const networkInterface = 'wlan0'

const network = Variable("", {
    poll: [
        1000,
        async () => {
            const output = await Utils.execAsync(`iwctl station ${networkInterface} show`);
            const outputArray = output.split('\n');
            const state = outputArray.find(line => line.includes('State')).replace('State', '').trim();
            if (state !== 'connected') {
                return 'Disconnected';
            }
            const ssid = outputArray.find(line => line.includes('Connected network')).replace('Connected network', '').trim();
            return `${ssid}  `;
        },
    ],
});

const vpn = Variable("", {
    poll: [
        1000,
        async () => {
            let pid = '';
            try {
                pid = await Utils.execAsync("pgrep openvpn");
            } catch(e) {}
            return pid
        },
    ],
})

const vpn_toggle = async () => {
    let isVpnActive = false
    try {
        const output = await Utils.execAsync("pgrep openvpn");
        if (!!output) {
            isVpnActive = true
        }
    } catch(e) {}
    if (!isVpnActive) {
        Utils.execAsync("pkexec vpn");
        return
    }
    Utils.execAsync("pkexec killall openvpn");
}

const networkWidget = Widget.EventBox({
    child: Widget.Box({
        className: "network",
        children: [
            Widget.EventBox({
                on_primary_click: () => {
                    Utils.exec(`kitty -e iwctl`);
                },
                child: Widget.Label({
                    label: network.bind(),
                }),
            }),
            Widget.EventBox({
                on_primary_click: () => {
                    vpn_toggle();
                },
                child: Widget.Label({
                    className: "vpn",
                    label: '  ',
                    setup: self => self.hook(vpn, () => {
                        // self.label = vpn.value? ' 󰬝 ' : ' 󰰪 ';
                        self.class_name = vpn.value? 'vpn on' : 'vpn';
                    })
                })
            })
        ]
    })
})

export default networkWidget;
