import GObject, {
    getter,
    ParamFlags,
    property,
    register,
    setter,
} from 'ags/gobject';
import AstalNetwork from 'gi://AstalNetwork';

const STATES: Record<AstalNetwork.State, string> = {
    [AstalNetwork.State.ASLEEP]: 'Asleep',
    [AstalNetwork.State.CONNECTED_GLOBAL]: 'Connected',
    [AstalNetwork.State.CONNECTED_LOCAL]: 'Disconnected',
    [AstalNetwork.State.CONNECTED_SITE]: 'Connected',
    [AstalNetwork.State.CONNECTING]: 'Connecting',
    [AstalNetwork.State.DISCONNECTED]: 'Disconnected',
    [AstalNetwork.State.DISCONNECTING]: 'Disconnecting',
    [AstalNetwork.State.UNKNOWN]: 'Unknown State',
};

const ICON_FALLBACK = 'network-error';

const NetworkType = (name: string, flags: ParamFlags) =>
    GObject.ParamSpec.enum(
        name,
        null,
        null,
        flags,
        AstalNetwork.Primary,
        AstalNetwork.Primary.UNKNOWN
    );

@register({
    GTypeName: 'ShellNetwork',
})
export class ShellNetwork extends GObject.Object {
    @property(AstalNetwork.Network)
    private network: AstalNetwork.Network;

    @property(NetworkType)
    networkType: AstalNetwork.Primary;

    @property(String)
    status: string;

    @property(String)
    iconName: string;

    @getter(Boolean)
    get wifiEnabled(): boolean {
        return this.network.wifi ? this.network.wifi.enabled : false;
    }

    @setter(Boolean)
    set wifiEnabled(value: boolean) {
        if (this.network.wifi) {
            this.network.wifi.enabled = value;
            this._handleChangeWifi();
        }
    }

    private _callback?: () => unknown;

    constructor() {
        super();

        this.network = AstalNetwork.get_default();
        this.status = STATES[this.network.state];
        this.networkType = this.network.primary;
        this.iconName = this.getIconName();
        this.network.bind_property(
            'primary',
            this,
            'network-type',
            GObject.BindingFlags.DEFAULT
        );
        this.network.bind_property_full(
            'state',
            this,
            'status',
            GObject.BindingFlags.DEFAULT,
            (_binding, from: AstalNetwork.State) => [true, STATES[from]],
            null
        );
        if (this.network.wifi)
            this.network.wifi.connect(
                'notify::enabled',
                this._handleChangeWifi.bind(this)
            );
        this._handleChange(this.network);
        this.network.connect('notify::primary', this._handleChange.bind(this));
    }

    private _handleChange(source: AstalNetwork.Network) {
        if (this._callback !== undefined) this._callback();
        let connType: 'wifi' | 'wired' | undefined;

        if (source.primary === AstalNetwork.Primary.WIRED) connType = 'wired';
        else if (source.primary === AstalNetwork.Primary.WIFI) {
            connType = 'wifi';
            this._handleChangeWifi();
            this.network.wifi.connect(
                'notify::enabled',
                this._handleChangeWifi.bind(this)
            );
        } else (this._callback = undefined), (this.iconName = ICON_FALLBACK);

        if (connType !== undefined) {
            const cb = (conn: { iconName: string }) =>
                (this.iconName = conn.iconName);

            const id = source[connType].connect(
                'notify::icon-name',
                cb.bind(this)
            );

            this._callback = () => {
                if (source[connType]) source[connType].disconnect(id);
            };
            this.iconName = source[connType].iconName;
        }
    }

    private _handleChangeWifi() {
        this.notify('wifi-enabled');
    }

    private getIconName() {
        if (this.networkType === AstalNetwork.Primary.WIRED)
            return this.network.wired.iconName;
        else if (this.networkType === AstalNetwork.Primary.WIFI)
            return this.network.wifi.iconName;
        return ICON_FALLBACK;
    }

    static get_default() {
        if (this.#instance === null) this.#instance = new ShellNetwork();
        return this.#instance;
    }

    static #instance: ShellNetwork | null = null;
}
