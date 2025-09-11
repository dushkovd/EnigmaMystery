export const motion: any = new Proxy({}, { get: () => (props: any) => props?.children || null });
export const AnimatePresence: any = ({ children }: any) => children ?? null;
export default { motion, AnimatePresence } as any;
