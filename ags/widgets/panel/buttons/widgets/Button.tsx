import type { Accessor } from 'ags';
import { Gtk } from 'ags/gtk4';
import { ButtonProps } from './ButtonProps';

interface SquareButtonProps {
    iconName: string | Accessor<string>;
    label: string;
    activated: Accessor<boolean>;
    toggle: () => unknown;
}

function Button(props: ButtonProps & SquareButtonProps) {
    return (
        <button
            $={props.setup}
            hexpand
            cssClasses={props.activated(enabled =>
                enabled ? ['suggested-action'] : []
            )}
            onClicked={props.toggle}
        >
            <box class="horizontal" spacing={4} halign={Gtk.Align.CENTER}>
                <image
                    iconSize={Gtk.IconSize.LARGE}
                    iconName={props.iconName}
                />
                <label label={props.label} />
            </box>
        </button>
    );
}

export default Button;
