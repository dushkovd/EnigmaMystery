import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';

const ScrollToTop = () => {
  const location = useLocation();

  useEffect(() => {
    // Do not scroll to top if the link is an anchor
    // or if the navigation state specifically says to prevent it.
    if (location.hash || location.state?.preventScroll) {
      return;
    }

    window.scrollTo(0, 0);
  }, [location.pathname]); // Only trigger on page change

  return null;
};

export default ScrollToTop; 