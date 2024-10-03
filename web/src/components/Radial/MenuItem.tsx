import React from 'react';

export interface MenuItemProps {
    id: string;
    title: string;
    items?: MenuItemProps[];
}

interface MenuItemElementProps {
    startAngle: number;
    endAngle: number;
    item?: MenuItemProps;
    index: number;
    innerRadius: number;
    radius: number;
    selectItem: () => void;
    closeOnClick: boolean;
}

const MenuItem: React.FC<MenuItemElementProps> = ({
    startAngle,
    endAngle,
    item,
    index,
    innerRadius,
    radius,
    selectItem,
    closeOnClick,
}) => {
    const sectorPath = createSectorCmds(startAngle, endAngle, innerRadius, radius);
    const midAngle = (startAngle + endAngle) / 2;
    const textPos = getDegreePos(midAngle, 40); // Position text a little inward

    return (
        <>
            <path
                d={sectorPath}
                className={item ? 'sector' : 'dummy'}
                data-index={index}
                data-id={item?.id}
                onClick={(event) => {
                    event.stopPropagation();
                    selectItem();
                }}
            />
            {item && (
                <text
                    textAnchor="middle"
                    fontSize="38%"
                    x={textPos.x}
                    y={textPos.y}
                >
                    {item.title}
                </text>
            )}
        </>
    );
};

const createSectorCmds = (startAngleDeg: number, endAngleDeg: number, innerRadius: number, radius: number) => {
    const initPoint = getDegreePos(startAngleDeg, radius);
    let path = `M ${initPoint.x} ${initPoint.y} `;
    path += `A ${radius} ${radius} 0 0 0 ${getDegreePos(endAngleDeg, radius).x} ${getDegreePos(endAngleDeg, radius).y} `;
    path += `L ${getDegreePos(endAngleDeg, innerRadius).x} ${getDegreePos(endAngleDeg, innerRadius).y} `;
    path += `A ${innerRadius} ${innerRadius} 0 0 1 ${getDegreePos(startAngleDeg, innerRadius).x} ${getDegreePos(startAngleDeg, innerRadius).y} `;
    path += 'Z';

    return path;
};

const getDegreePos = (angleDeg: number, length: number) => {
    return {
        x: Math.sin(degToRad(angleDeg)) * length,
        y: Math.cos(degToRad(angleDeg)) * length,
    };
};

const degToRad = (deg: number) => {
    return (deg * Math.PI) / 180;
};

export default MenuItem;
