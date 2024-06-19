// Will return whether the current environment is in a regular browser
// and not CEF
export const isEnvBrowser = (): boolean => !(window as any).invokeNative;

// Basic no operation function
export const noop = () => {};

export const splitFAString = (faString:string) => {
  const [prefix, newIcon] = faString.split('-');
  if (!prefix || !newIcon) return {prefix: 'fas', newIcon: 'question'};
  return {prefix, newIcon};
}