import { reactWidget } from 'reactR';
import { ResponsiveCalendar, ResponsiveCalendarCanvas } from '@nivo/calendar';
import { ResponsiveAreaBump, ResponsiveBump } from '@nivo/bump';

reactWidget(
  'calendar',
  'output',
  { 
    ResponsiveCalendar, 
    ResponsiveCalendarCanvas, 
    ResponsiveAreaBump, 
    ResponsiveBump
  },
  {},
);
