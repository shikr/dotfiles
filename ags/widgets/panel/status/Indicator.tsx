import { Accessor } from 'ags';

interface IndicatorProps {
    iconName: string | Accessor<string>;
    tooltip: string | Accessor<string>;
}

function Indicator(props: IndicatorProps) {
    return <image iconName={props.iconName} tooltipText={props.tooltip} />;
}

export default Indicator;
