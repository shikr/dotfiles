import { monitorFile, readFile, writeFile } from 'ags/file';
import GObject, { property, register } from 'ags/gobject';
import Gio from 'gi://Gio';
import GLib from 'gi://GLib';

interface SettingsProperties {
    icon: string;
    style: 'default' | 'floating';
    position: 'top' | 'bottom';
}

const DEFAULTS: SettingsProperties = {
    icon: 'start-here-symbolic',
    style: 'default',
    position: 'top',
};

const StaticString =
    <T extends keyof SettingsProperties>(defaultValue: SettingsProperties[T]) =>
    (name: string, flags: GObject.ParamFlags) =>
        GObject.ParamSpec.string(
            name,
            null,
            null,
            flags,
            defaultValue
        ) as GObject.ParamSpec<SettingsProperties[T]>;

@register({ GTypeName: 'Settings' })
export class Settings extends GObject.Object implements SettingsProperties {
    @property(String)
    icon: string = DEFAULTS.icon;

    @property(StaticString<'style'>('default'))
    style: 'default' | 'floating' = DEFAULTS.style;

    @property(StaticString<'position'>('bottom'))
    position: 'top' | 'bottom' = DEFAULTS.position;

    static #instance: Settings | null = null;

    static get_default() {
        if (this.#instance === null) this.#instance = new Settings();
        return this.#instance;
    }

    constructor() {
        super();

        this._syncSelf();

        monitorFile(Settings.getFilePath(), this._syncSelf.bind(this));

        for (const prop in DEFAULTS) {
            this.connect('notify::' + prop, this._syncFile.bind(this));
        }
    }

    private _syncSelf() {
        const file = Settings.getFile();

        if (file === null) return;

        let data: Partial<SettingsProperties>;
        try {
            data = JSON.parse(readFile(file.get_path()!));
        } catch {
            data = {};
        }

        for (const prop of Object.keys(data) as (keyof SettingsProperties)[])
            if (prop in this && data[prop] !== this[prop])
                (this as any)[prop] = data[prop];
    }

    private _syncFile() {
        const path = Settings.getFilePath();

        const data = Object.fromEntries(
            Object.entries(DEFAULTS).map(([key]) => [
                key,
                this[key as keyof SettingsProperties],
            ])
        );

        writeFile(path, JSON.stringify(data, null, 4));
    }

    private static getFile() {
        const file = Gio.File.new_for_path(this.getFilePath());
        if (!file.query_exists(null)) return null;
        return file;
    }

    private static getFilePath() {
        return GLib.build_filenamev([
            GLib.get_user_config_dir(),
            'shell',
            'settings.json',
        ]);
    }
}
