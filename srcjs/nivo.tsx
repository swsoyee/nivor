import { reactWidget } from 'reactR';
import { ResponsiveCalendar, ResponsiveCalendarCanvas } from '@nivo/calendar';
import { ResponsiveAreaBump, ResponsiveBump } from '@nivo/bump';
import { ResponsiveLine, ResponsiveLineCanvas } from '@nivo/line';
import { ResponsiveScatterPlot, ResponsiveScatterPlotCanvas } from "@nivo/scatterplot";

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
    ResponsiveScatterPlot,
    ResponsiveScatterPlotCanvas,
  },
  {},
);
