import { createBinding, With } from 'ags';
import AstalNetwork from 'gi://AstalNetwork';
import { ShellNetwork } from '../../../utils/network';
import Button from './widgets/Button';
import { ButtonProps } from './widgets/ButtonProps';

function WifiButton({ setup }: ButtonProps) {
    const network = ShellNetwork.get_default();

    return (
        <With value={createBinding(network, 'networkType')}>
            {(value: AstalNetwork.Primary) => {
                // TODO: Show a button when a Wi-Fi device is available
                if (value !== AstalNetwork.Primary.WIFI) return false;

                return (
                    <Button
                        label="Wi-Fi"
                        setup={setup}
                        iconName="network-wireless-connected-symbolic"
                        activated={createBinding(network, 'wifiEnabled')}
                        toggle={() =>
                            (network.wifiEnabled = !network.wifiEnabled)
                        }
                    />
                );
            }}
        </With>
    );
}

export default WifiButton;
