import { Gtk } from 'ags/gtk4';

export interface ButtonProps {
    setup: (widget: Gtk.Widget) => unknown;
}
