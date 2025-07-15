export interface Geometry {
    width: number;
    height: number;
}

export function optimalGeometry(size: number) {
    const result: Geometry = {
        height: 0,
        width: 0,
    };
    let minDiff = size;

    for (let h = 1; h <= Math.sqrt(size); h++) {
        if (size % h == 0) {
            const w = Math.floor(size / h);
            if (w >= h) {
                const diff = w - h;
                if (diff < minDiff) {
                    result.width = w;
                    result.height = h;
                    minDiff = diff;
                }
            }
        }
    }

    return result;
}
