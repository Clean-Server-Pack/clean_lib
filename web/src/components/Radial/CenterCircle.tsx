import React from 'react';

interface CenterCircleProps {
    innerRadius: number;
}

const CenterCircle: React.FC<CenterCircleProps> = ({ innerRadius }) => {
    return (
        <circle
            cx="0"
            cy="0"
            r={innerRadius - 1} // Adjust radius as needed
            className="center-circle"
        />
    );
};

export default CenterCircle;
