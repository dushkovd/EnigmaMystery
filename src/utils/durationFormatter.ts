// Utility function to format duration with language-specific text
export const formatDuration = (duration: string, language: 'en' | 'bg'): string => {
  if (!duration) return '';
  
  // Extract numbers from duration string (e.g., "2-3 hours" -> "2-3")
  const numbers = duration.match(/\d+(?:-\d+)?/);
  if (!numbers) return duration;
  
  const numberPart = numbers[0];
  
  // Return formatted string with appropriate language text
  if (language === 'bg') {
    return `${numberPart} часа`;
  } else {
    return `${numberPart} hours`;
  }
}; 