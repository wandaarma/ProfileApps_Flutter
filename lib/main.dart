import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatefulWidget {
  const ProfileApp({super.key});

  @override
  State<ProfileApp> createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      theme:
          _isDarkMode
              ? ThemeData.dark()
              : ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primaryColor: const Color(0xFF001F54),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF001F54),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                textTheme: TextTheme(
                  headlineSmall: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : const Color(0xFF001F54),
                  ),
                  titleLarge: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black87,
                  ),
                  bodyMedium: TextStyle(
                    color: _isDarkMode ? Colors.white70 : Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
      home: ProfileScreen(
        isDarkMode: _isDarkMode,
        onThemeToggle: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class SkillProgress extends StatelessWidget {
  final String skill;
  final double level;
  final bool isDarkMode;

  const SkillProgress({
    super.key,
    required this.skill,
    required this.level,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          skill,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: level,
          backgroundColor: isDarkMode ? Colors.white24 : Colors.black12,
          color: isDarkMode ? Colors.tealAccent : const Color(0xFF001F54),
          minHeight: 8,
        ),
      ],
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> skills = [
    'Machine Learning',
    'Data Analysis',
    'Data Visualization',
    'Python',
    'SQL',
    'Web Programming',
  ];

  final Map<String, double> skillLevels = {
    'Machine Learning': 0.90,
    'Data Analysis': 0.90,
    'Data Visualization' : 0.80,
    'Python': 0.85,
    'SQL': 0.70,
    'Web Programming' : 0.75,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? Colors.black87 : const Color(0xFF001F54),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: const AssetImage('assets/images/foto_diri.jpg'),
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(height: 12),
          Text(
            'Wanda Armadianti | 5026211039',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Data Analyst Intern | Information Systems Student',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _launchUrl('https://www.linkedin.com/in/wandaarma/');
                },
                icon: const Icon(Icons.person_add, size: 16),
                label: const Text('Connect'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF001F54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  _launchUrl('https://wa.me/6285707694628');
                },
                icon: const Icon(Icons.message, size: 16),
                label: const Text('Message'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSummary() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Final-year Information Systems student with a strong foundation in IT, data analytics, and technology-driven decision-making. With hands-on experience in data analysis, machine learning, and business intelligence through internships at Bank Rakyat Indonesia and ID/X Partners, I am skilled in Python, Power BI, and data-driven problem-solving. Passionate about optimizing business processes through analytics, I am adaptable to various IT roles, from data analysis to system development, with a keen interest in leveraging technology for innovation and efficiency.',
        style: TextStyle(
          fontSize: 16,
          color: widget.isDarkMode ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }

  Widget buildExperience() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExperienceItem(
            position: 'Data Analyst Intern',
            company: 'PT. Bank Rakyat Indonesia (Persero) Tbk.',
            period: 'Sep 2024 - Dec 2024',
            description:
                'As a Data Analyst Intern at International Business Division, I was responsible for analyzing data using Excel and Power BI, automating business processes, and contributing to international business operations.',
          ),
          SizedBox(height: 8),
          Divider(thickness: 1, color: Colors.grey.shade300),
          SizedBox(height: 8),
          ExperienceItem(
            position: 'Teaching Assistant of Statistics and Probabilistics',
            company:
                'Information System Department, Institut Teknologi Sepuluh Nopember',
            period: 'Mar 2024 - Jun 2024',
            description:
                'As a Statistics and Probabilistic Assistant Lecturer, I am responsible for delivering comprehensive lectures and practical sessions to over 50 students enrolled in the Information Systems Department with a focus on enhancing students understanding and proficiency in statistical concepts and probabilistic theories.',
          ),
          SizedBox(height: 8),
          Divider(thickness: 1, color: Colors.grey.shade300),
          SizedBox(height: 8),
          ExperienceItem(
            position: 'Data Scientist Intern',
            company: 'ID/X Partners',
            period: 'Jan 2024',
            description:
                'Learning modules and coaching videos about Data Analysis, SQL, Data Warehouse, Machine Learning, and Deep Learning, complete practical assignments and final project that focuses on credit risk analysis and prediction.',
          ),
        ],
      ),
    );
  }

  Widget buildEducation() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExperienceItem(
            position: 'S1 - Sistem Informasi',
            company: 'Institut Teknologi Sepuluh Nopember',
            period: '2021 - Now',
            description:
                'Focus on data science, business process, and information technology',
          ),
          SizedBox(height: 8),
          Divider(thickness: 1, color: Colors.grey.shade300),
          SizedBox(height: 8),
          ExperienceItem(
            position: 'SMA Negeri 2 Jombang',
            company: 'Jombang',
            period: '2018 - 2021',
            description: 'Focus on science',
          ),
        ],
      ),
    );
  }

  Widget buildSkills() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children:
            skills.map((skill) {
              double level = skillLevels[skill] ?? 0.5;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SkillProgress(
                  skill: skill,
                  level: level,
                  isDarkMode: widget.isDarkMode,
                ),
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text(
          'About Me',
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
        ],
        backgroundColor: const Color(0xFF001F54),
      ),
      body: Column(
        children: [
          buildHeader(),
          TabBar(
            controller: _tabController,
            labelColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.tealAccent
                    : const Color(0xFF001F54),
            unselectedLabelColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.black54,
            indicatorColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.tealAccent
                    : const Color(0xFF001F54),
            tabs: const [
              Tab(text: 'Summary'),
              Tab(text: 'Experience'),
              Tab(text: 'Education'),
              Tab(text: 'Skills'),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(child: buildSummary()),
                SingleChildScrollView(child: buildExperience()),
                SingleChildScrollView(child: buildEducation()),
                SingleChildScrollView(child: buildSkills()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceItem extends StatelessWidget {
  final String position;
  final String company;
  final String period;
  final String description;

  const ExperienceItem({
    super.key,
    required this.position,
    required this.company,
    required this.period,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          position,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : const Color(0xFF001F54),
          ),
        ),
        Text(
          company,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        Text(
          period,
          style: TextStyle(color: isDarkMode ? Colors.white60 : Colors.black54),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
        ),
      ],
    );
  }
}
