import { Flex, useMantineTheme } from "@mantine/core";
import colorWithAlpha from "../../utils/colorWithAlpha";

type ProgressProps = {
  size?: string;
  w?: string;
  value: number; // Ensure a number is always passed
};

export default function Progress(props: ProgressProps) {
  const theme = useMantineTheme();

  // Prevent rendering the progress bar for invalid or zero width
  if (props.value <= 0) {
    return null;
  }

  return (
    <Flex w={props.w || "100%"}>
      <Flex
        w={`${props.value}%`}
        bg={colorWithAlpha(theme.colors[theme.primaryColor][9], 0.7)}
        h={props.size || "0.5vh"}
        style={{
          transition: "all ease-in-out 0.3s",
        }}
      />
    </Flex>
  );
}
