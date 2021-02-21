import { reactWidget } from 'reactR';
import { ResponsiveCalendar, ResponsiveCalendarCanvas } from '@nivo/calendar';
import { ResponsiveAreaBump, ResponsiveBump } from '@nivo/bump';
import { ResponsiveLine, ResponsiveLineCanvas } from '@nivo/line';

reactWidget(
  'calendar',
  'output',
  { 
    ResponsiveCalendar, 
    ResponsiveCalendarCanvas, 
    ResponsiveAreaBump, 
    ResponsiveBump,
    ResponsiveLine, 
    ResponsiveLineCanvas,
  },
  {},
);
