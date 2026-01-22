import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/common/widgets.dart';
import 'job_category.dart';

class JobCategoryPage extends StatefulWidget {
  const JobCategoryPage({super.key});

  @override
  State<JobCategoryPage> createState() => _JobCategoryPageState();
}

class _JobCategoryPageState extends State<JobCategoryPage> {
  final _searchController = TextEditingController();
  List<JobCategory> _filteredCategories = JobCategories.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _filteredCategories = JobCategories.search(query);
    });
  }

  void _showCategoryDetail(JobCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JobCategoryDetailPage(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Job Categories',
      body: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4ECDC4).withOpacity(0.1),
                  const Color(0xFF44A08D).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4ECDC4).withOpacity(0.3),
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch,
              style: GoogleFonts.inter(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search categories, skills, jobs...',
                hintStyle: GoogleFonts.inter(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                prefixIcon: Icon(Icons.search, color: const Color(0xFF4ECDC4)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          _onSearch('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Category Count
          Row(
            children: [
              Icon(Icons.category, size: 18, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                '${_filteredCategories.length} categories found',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Category Grid
          Expanded(
            child: _filteredCategories.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No categories found',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: _filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = _filteredCategories[index];
                      return _CategoryCard(
                        category: category,
                        onTap: () => _showCategoryDetail(category),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final JobCategory category;
  final VoidCallback onTap;

  const _CategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              category.color.withOpacity(0.15),
              category.color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: category.color.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(category.icon, color: category.color, size: 26),
              ),
              const SizedBox(height: 12),

              // Name
              Text(
                category.name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Thai Name
              Text(
                category.nameTh,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: category.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),

              // Sample jobs preview
              Text(
                category.sampleJobs.take(2).join(', '),
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================
// Category Detail Page
// ===========================

class JobCategoryDetailPage extends StatelessWidget {
  final JobCategory category;

  const JobCategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: category.name,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    category.color.withOpacity(0.2),
                    category.color.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(category.icon, color: category.color, size: 44),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category.name,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.nameTh,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: category.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.paid,
                          size: 18,
                          color: Colors.green.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category.salaryRange,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Description
            _SectionCard(
              title: 'Description',
              icon: Icons.info_outline,
              color: category.color,
              child: Text(
                category.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Skills Required
            _SectionCard(
              title: 'Skills Required',
              icon: Icons.psychology,
              color: category.color,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: category.skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: category.color.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      skill,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: category.color,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Sample Jobs
            _SectionCard(
              title: 'Sample Job Titles',
              icon: Icons.work_outline,
              color: category.color,
              child: Column(
                children: category.sampleJobs.map((job) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_right,
                          color: category.color,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            job,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
