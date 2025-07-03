import { Accessor } from 'ags';

interface IndicatorProps {
    iconName: string | Accessor<string>;
    tooltip: string | Accessor<string>;
}

function Indicator(props: IndicatorProps) {
    return (
        <image
            pixelSize={14}
            iconName={props.iconName}
            tooltipText={props.tooltip}
        />
    );
}

export default Indicator;
