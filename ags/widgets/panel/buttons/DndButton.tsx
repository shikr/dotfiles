import { createBinding } from 'ags';
import AstalNotifd from 'gi://AstalNotifd';
import Button from './widgets/Button';
import { ButtonProps } from './widgets/ButtonProps';

function DndButton({ setup }: ButtonProps) {
    const notifd = AstalNotifd.get_default();
    const dontDisturb = createBinding(notifd, 'dontDisturb');

    return (
        <Button
            iconName={dontDisturb(enabled =>
                enabled
                    ? 'notifications-disabled-symbolic'
                    : 'notifications-symbolic'
            )}
            label="Don't Disturb"
            activated={dontDisturb}
            setup={setup}
            toggle={() => (notifd.dontDisturb = !notifd.dontDisturb)}
        />
    );
}

export default DndButton;
