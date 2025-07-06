function BarPopover({ $, ...props }: JSX.IntrinsicElements['popover']) {
    return (
        <popover
            $={(...args) => {
                const [self] = args;
                self.set_offset(0, 10);
                if ($) return $(...args);
            }}
            hasArrow={false}
            {...props}
        />
    );
}

export default BarPopover;
