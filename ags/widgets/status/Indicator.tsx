interface IndicatorProps {
    iconName: string;
    tooltip: string;
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
