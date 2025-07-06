function BarButton({
    cssClasses,
    iconName,
    ...props
}: JSX.IntrinsicElements['menubutton']) {
    const combine = (...classes: string[]) => {
        if (typeof cssClasses === 'function')
            return cssClasses(x => [...classes, ...x]);
        return [...classes, ...(cssClasses ?? [])];
    };

    return (
        <menubutton
            iconName={iconName}
            cssClasses={
                Boolean(iconName)
                    ? combine('raised', 'image-button')
                    : combine('raised')
            }
            {...props}
        />
    );
}

export default BarButton;
