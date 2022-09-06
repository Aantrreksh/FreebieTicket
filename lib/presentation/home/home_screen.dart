import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_app/domain/ext.dart';
import 'package:ticket_app/presentation/home/home_viewmodel.dart';
import 'package:ticket_app/presentation/styles/app_colors.dart';
import 'package:ticket_app/presentation/widgets/upcoming_events_item.dart';

import '../resources/asset_images.dart';
import '../widgets/collection_item.dart';
import '../widgets/filter_item.dart';
import 'home_mock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  void initState() {
    _homeViewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overflow) {
        overflow.disallowIndicator();
        return false;
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 45),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'For you',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AssetImages.filterIcon,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 79),
            Center(
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(AssetImages.filters),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tap to set filters.',
                      style: TextStyle(
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 111),
            Text(
              'Collections',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 160,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: collections.length,
                  itemBuilder: (context, index) => SizedBox(
                    child: CollectionItem(
                      collection: collections[index],
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                ),
              ),
            ),
            const SizedBox(height: 55),
            Text(
              'Discover',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 15),
            Consumer(
              builder: (context, ref, child) => SizedBox(
                height: 60,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: FilterItem(
                        filter: filters[index],
                        selected: ref.isSelected(index),
                        onTap: () => ref.setSelectedFilter(index),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemCount: filters.length,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 55),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AssetImages.locationIcon),
                const SizedBox(width: 8),
                Text(
                  'Warsaw'.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.red,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 25),

            // ListView.separated(
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) => UpcomingDayItem(
            //     date: upcomingDayItemList[index].date,
            //     dayUpcomingList: upcomingDayItemList[index],
            //   ),
            //   separatorBuilder: (context, index) => const SizedBox(height: 10),
            //   itemCount: upcomingDayItemList.length,
            // )
            StaggeredGrid.count(
              crossAxisCount: MediaQuery.of(context).size.width ~/ 340,
              axisDirection: AxisDirection.down,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: List.generate(
                _homeViewModel.upcomingEvents.length,
                (index) {
                  upcomingEvents.sort((a, b) => a.date.compareTo(b.date));
                  return UpcomingEventsItem(
                    upcomingEvents: _homeViewModel.upcomingEvents[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
