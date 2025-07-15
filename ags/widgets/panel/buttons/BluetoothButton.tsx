import { createBinding, With } from 'ags';
import AstalBluetooth from 'gi://AstalBluetooth';
import Button from './widgets/Button';
import { ButtonProps } from './widgets/ButtonProps';

function BluetoothButton({ setup }: ButtonProps) {
    const bluetooth = AstalBluetooth.get_default();
    const powered = createBinding(bluetooth, 'isPowered');

    return (
        <With value={createBinding(bluetooth, 'adapters')}>
            {(adapters: AstalBluetooth.Adapter[]) =>
                adapters.length > 0 && (
                    <Button
                        setup={setup}
                        label="Bluetooth"
                        activated={powered}
                        toggle={() => bluetooth.toggle()}
                        iconName={powered(enabled =>
                            enabled
                                ? 'bluetooth-active-symbolic'
                                : 'bluetooth-disabled-symbolic'
                        )}
                    />
                )
            }
        </With>
    );
}

export default BluetoothButton;
