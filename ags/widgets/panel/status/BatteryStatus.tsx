import { createBinding, createComputed, With } from 'ags';
import AstalBattery from 'gi://AstalBattery';
import Indicator from './Indicator';

const states: Record<AstalBattery.State, string> = {
    [AstalBattery.State.UNKNOWN]: 'Unknown status',
    [AstalBattery.State.PENDING_CHARGE]: 'Pending Charge',
    [AstalBattery.State.FULLY_CHARGED]: 'Fully Charged',
    [AstalBattery.State.CHARGING]: 'Charging',
    [AstalBattery.State.DISCHARGING]: 'Discharging',
    [AstalBattery.State.PENDING_DISCHARGE]: 'Pending Discharge',
    [AstalBattery.State.EMPTY]: 'Empty',
};

function BatteryStatus() {
    const battery = AstalBattery.get_default();
    const c = createComputed(
        [
            createBinding(battery, 'batteryIconName'),
            createBinding(battery, 'device_type'),
            createBinding(battery, 'state'),
        ],
        (batteryIconName, deviceType, state) => ({
            batteryIconName,
            deviceType,
            state,
        })
    );

    return (
        <With value={c}>
            {({ batteryIconName, deviceType, state }) => {
                if (deviceType !== AstalBattery.Type.BATTERY) return false;

                return (
                    <Indicator
                        iconName={batteryIconName}
                        tooltip={states[state]}
                    />
                );
            }}
        </With>
    );
}

export default BatteryStatus;
