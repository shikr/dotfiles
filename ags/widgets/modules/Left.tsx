import { Gtk } from 'ags/gtk4';
import { execAsync } from 'ags/process';

function Left() {
    return (
        <box $type="start" class="horizontal" halign={Gtk.Align.START}>
            <button
                onClicked={() => execAsync('echo hello').then(console.log)}
                cssClasses={['raised', 'image-button']}
                iconName="start-here"
            />
        </box>
    );
}

export default Left;
