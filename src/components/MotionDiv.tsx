import React, { PropsWithChildren, useEffect, useMemo, useState } from 'react';

// A lightweight wrapper that lazy-loads framer-motion only when needed.
// Until the library loads, it renders a plain <div> so it does not block FCP/LCP.

export type MotionDivProps = React.HTMLAttributes<HTMLDivElement> & {
  // These props mirror common framer-motion props. They are typed as any to avoid
  // importing framer-motion types at compile time. They will be forwarded when available.
  initial?: any;
  animate?: any;
  whileInView?: any;
  transition?: any;
  viewport?: any;
};

export const MotionDiv: React.FC<PropsWithChildren<MotionDivProps>> = ({ children, ...rest }) => {
  const [FM, setFM] = useState<any>(null);

  useEffect(() => {
    // Load on idle to avoid competing with critical rendering
    const load = () => import('framer-motion').then(mod => setFM(mod));
    if ('requestIdleCallback' in window) {
      // @ts-ignore
      (window as any).requestIdleCallback(load, { timeout: 1500 });
    } else {
      setTimeout(load, 800);
    }
  }, []);

  // If not loaded yet, render a normal div without animation props
  if (!FM) {
    const { initial, animate, whileInView, transition, viewport, ...divProps } = rest as any;
    return <div {...divProps}>{children}</div>;
  }

  const MDiv = useMemo(() => FM.motion.div, [FM]);
  return <MDiv {...(rest as any)}>{children}</MDiv>;
};
