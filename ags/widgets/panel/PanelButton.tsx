import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import Panel from './Panel';
import BatteryStatus from './status/BatteryStatus';
import NetworkStatus from './status/NetworkStatus';
import SpeakerStatus from './status/SpeakerStatus';

function PanelButton() {
    return (
        <BarButton>
            <box spacing={6} class="horizontal">
                <NetworkStatus />
                <SpeakerStatus />
                <BatteryStatus />
            </box>
            <BarPopover>
                <Panel />
            </BarPopover>
        </BarButton>
    );
}

export default PanelButton;
