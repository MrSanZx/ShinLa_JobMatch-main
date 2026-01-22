import 'package:flutter/material.dart';

class JobCategory {
  final String id;
  final String name;
  final String nameTh;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> skills;
  final List<String> sampleJobs;
  final String salaryRange;

  const JobCategory({
    required this.id,
    required this.name,
    required this.nameTh,
    required this.icon,
    required this.color,
    required this.description,
    required this.skills,
    required this.sampleJobs,
    required this.salaryRange,
  });
}

class JobCategories {
  static const List<JobCategory> all = [
    JobCategory(
      id: 'it',
      name: 'Technology',
      nameTh: 'เทคโนโลยีและไอที',
      icon: Icons.computer,
      color: Color(0xFF4ECDC4), // Minty Blue
      description:
          'Software development, data analysis, and system administration roles for tech-savvy individuals.',
      skills: ['Flutter', 'Python', 'React', 'Cloud Computing', 'SQL'],
      sampleJobs: ['Mobile Developer', 'Data Analyst', 'DevOps Engineer'],
      salaryRange: '฿25,000 - ฿150,000',
    ),
    JobCategory(
      id: 'design',
      name: 'Creative & Design',
      nameTh: 'ออกแบบและสร้างสรรค์',
      icon: Icons.palette,
      color: Color(0xFF9B5DE5), // Purple
      description:
          'Roles involving visual design, user experience, and creative content creation.',
      skills: ['Figma', 'Adobe Suite', 'UI/UX', 'Video Editing', '3D Modeling'],
      sampleJobs: ['UI/UX Designer', 'Graphic Designer', 'Video Editor'],
      salaryRange: '฿20,000 - ฿100,000',
    ),
    JobCategory(
      id: 'marketing',
      name: 'Marketing',
      nameTh: 'การตลาด',
      icon: Icons.campaign,
      color: Color(0xFFF15BB5), // Pink/Magenta
      description:
          'Strategy, branding, and communication roles to promote products and services.',
      skills: [
        'SEO/SEM',
        'Content Writing',
        'Social Media',
        'Analytics',
        'Branding',
      ],
      sampleJobs: ['Digital Marketer', 'Content Creator', 'Brand Manager'],
      salaryRange: '฿22,000 - ฿120,000',
    ),
    JobCategory(
      id: 'finance',
      name: 'Finance',
      nameTh: 'การเงินและบัญชี',
      icon: Icons.attach_money,
      color: Color(0xFF00BBF9), // Blue
      description:
          'Managing financial records, analysis, and investment strategies.',
      skills: [
        'Accounting',
        'Financial Analysis',
        'Excel',
        'Taxation',
        'Auditing',
      ],
      sampleJobs: ['Accountant', 'Financial Analyst', 'Auditor'],
      salaryRange: '฿20,000 - ฿130,000',
    ),
    JobCategory(
      id: 'engineering',
      name: 'Engineering',
      nameTh: 'วิศวกรรม',
      icon: Icons.engineering,
      color: Color(0xFFFEE440), // Yellow
      description:
          'Design, construction, and maintenance of structures, machines, and systems.',
      skills: [
        'AutoCAD',
        'Project Management',
        'Circuit Design',
        'Structural Analysis',
      ],
      sampleJobs: [
        'Civil Engineer',
        'Electrical Engineer',
        'Mechanical Engineer',
      ],
      salaryRange: '฿25,000 - ฿100,000',
    ),
    JobCategory(
      id: 'business',
      name: 'Business',
      nameTh: 'บริหารธุรกิจ',
      icon: Icons.business_center,
      color: Color(0xFF00F5D4), // Cyan
      description:
          'Roles focused on business operations, strategy, and management.',
      skills: ['Leadership', 'Strategic Planning', 'Negotiation', 'Operations'],
      sampleJobs: ['Business Analyst', 'Project Manager', 'Consultant'],
      salaryRange: '฿30,000 - ฿150,000',
    ),
    JobCategory(
      id: 'sales',
      name: 'Sales',
      nameTh: 'การขาย',
      icon: Icons.storefront,
      color: Color(0xFFFF9F1C), // Orange
      description:
          'Direct sales, customer relationship management, and business development.',
      skills: ['Negotiation', 'CRM', 'Communication', 'Lead Generation'],
      sampleJobs: [
        'Sales Executive',
        'Account Manager',
        'Sales Representative',
      ],
      salaryRange: '฿18,000 - ฿100,000+',
    ),
    JobCategory(
      id: 'hr',
      name: 'Human Resources',
      nameTh: 'ทรัพยากรบุคคล',
      icon: Icons.people_alt,
      color: Color(0xFF2EC4B6), // Teal
      description:
          'Recruitment, employee relations, and organizational development.',
      skills: [
        'Recruiting',
        'Employee Relations',
        'Labor Law',
        'Performance Mgmt',
      ],
      sampleJobs: ['HR Specialist', 'Recruiter', 'Talent Acquisition'],
      salaryRange: '฿20,000 - ฿90,000',
    ),
  ];

  static List<JobCategory> search(String query) {
    final lowerQuery = query.toLowerCase();
    return all.where((category) {
      final matchesName = category.name.toLowerCase().contains(lowerQuery);
      final matchesNameTh = category.nameTh.toLowerCase().contains(lowerQuery);
      final matchesSkills = category.skills.any(
        (skill) => skill.toLowerCase().contains(lowerQuery),
      );
      final matchesJobs = category.sampleJobs.any(
        (job) => job.toLowerCase().contains(lowerQuery),
      );
      return matchesName || matchesNameTh || matchesSkills || matchesJobs;
    }).toList();
  }
}
