import type { Accessor } from 'ags';

interface SliderProps {
    startWidget?: JSX.Element;
    min: number;
    max: number;
    value: Accessor<number>;
    updateValue: (value: number) => void;
    label: string | Accessor<string>;
}

function Slider({
    startWidget,
    min,
    max,
    label,
    updateValue,
    value,
}: SliderProps) {
    return (
        <box cssClasses={['horizontal', 'osd', 'toolbar']}>
            {startWidget}
            <slider
                hexpand
                min={min}
                max={max}
                value={value}
                onChangeValue={self => updateValue(self.value)}
            />
            <label label={label} />
        </box>
    );
}

export default Slider;
