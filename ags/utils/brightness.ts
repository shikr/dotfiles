import { monitorFile, readFile, writeFileAsync } from 'ags/file';
import GObject, { getter, property, register, setter } from 'ags/gobject';
import Gio from 'gi://Gio';

const BRIGHTNESS_DIR = '/sys/class/backlight';

@register({ GTypeName: 'Brightness' })
export class Brightness extends GObject.Object {
    static #instance: Brightness | null = null;

    static get_default() {
        if (this.#instance === null) this.#instance = new Brightness();

        return this.#instance;
    }

    #device: string | null;
    #brightness: number | null;
    #maxBrightness: number | null;

    @property(Boolean)
    isAvailable = false;

    @property(String)
    iconName = 'display-brightness-symbolic';

    @getter(Number)
    get brightness() {
        return this.#brightness ?? 0;
    }

    @setter(Number)
    set brightness(value: number) {
        const path = this._getFilePath('brightness');
        const callback = () => {
            this.#brightness = value;
            this.notify('brightness');
        };
        if (path !== null)
            writeFileAsync(path, value.toString()).then(callback.bind(this));
    }

    @getter(Number)
    get maxBrightness() {
        return this.#maxBrightness ?? 100;
    }

    constructor() {
        super();

        this.#device = Brightness._getDevice();
        this.#brightness = this._getFileContent('brightness');
        this.#maxBrightness = this._getFileContent('max_brightness');

        this.isAvailable = this.#device !== null;

        const brightnessPath = this._getFilePath('brightness');
        if (brightnessPath !== null)
            monitorFile(brightnessPath, file => {
                const value = Number(readFile(file));
                this.#brightness = value;
                this.notify('brightness');
            });

        this._handleBrightnessChange();
        this.connect(
            'notify::brightness',
            this._handleBrightnessChange.bind(this)
        );
    }

    private _handleBrightnessChange() {
        if (this.#brightness === null || this.#brightness <= 0)
            this.iconName = 'display-brightness-off-symbolic';
        else {
            const brightnessPercent =
                (this.#brightness / this.maxBrightness) * 100;

            if (brightnessPercent < 33)
                this.iconName = 'display-brightness-low-symbolic';
            else if (brightnessPercent < 66)
                this.iconName = 'display-brightness-medium-symbolic';
            else this.iconName = 'display-brightness-symbolic';
        }
    }

    private _getFilePath(file: string) {
        return this.#device !== null
            ? Gio.File.new_for_path(BRIGHTNESS_DIR)
                  .get_child(this.#device)
                  .get_child(file)
                  .get_path()
            : null;
    }

    private _getFileContent(file: string) {
        const path = this._getFilePath(file);

        return path !== null ? Number(readFile(path)) : null;
    }

    private static _getDevice() {
        try {
            return (
                Gio.File.new_for_path(BRIGHTNESS_DIR)
                    .enumerate_children(
                        'standard::*',
                        Gio.FileQueryInfoFlags.NONE,
                        null
                    )
                    .next_file(null)
                    ?.get_name() ?? null
            );
        } catch {
            return null;
        }
    }
}
