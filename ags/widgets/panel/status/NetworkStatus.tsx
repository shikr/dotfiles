import { createBinding } from 'ags';
import { ShellNetwork } from '../../../utils/network';
import Indicator from './Indicator';

function NetworkStatus() {
    const network = ShellNetwork.get_default();
    const state = createBinding(network, 'status');
    const iconName = createBinding(network, 'iconName');

    return <Indicator iconName={iconName} tooltip={state} />;
}

export default NetworkStatus;
