﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;
using Composite.Core.Logging;


namespace Composite.Core.PackageSystem.Foundation
{
	internal class PackageServerFacadeImplCache
	{
        private TimeSpan _cacheLiveTime;

        private DateTime _packageDescriptionsCacheTimestamp = DateTime.MinValue;
        private Dictionary<string, Dictionary<Guid, Dictionary<CultureInfo, List<PackageDescription>>>> _packageDescriptionsCache = new Dictionary<string, Dictionary<Guid, Dictionary<CultureInfo, List<PackageDescription>>>>();


        public PackageServerFacadeImplCache()
        {
            _cacheLiveTime = TimeSpan.FromMinutes(30);
            if (RuntimeInformation.IsDebugBuild)
            {
                _cacheLiveTime = TimeSpan.FromSeconds(30);
            }
        }


        public List<PackageDescription> GetCachedPackageDescription(string packageServerUrl, Guid installationId, CultureInfo userCulture)
        {
            if ((_packageDescriptionsCacheTimestamp + _cacheLiveTime) < DateTime.Now)
            {
                LoggingService.LogVerbose("PackageServerFacadeCache", "PackageDescription cache miss");
                return null;
            }

            Dictionary<Guid, Dictionary<CultureInfo, List<PackageDescription>>> dic1;
            if (_packageDescriptionsCache.TryGetValue(packageServerUrl, out dic1) == false)
            {
                dic1 = new Dictionary<Guid, Dictionary<CultureInfo, List<PackageDescription>>>();
                _packageDescriptionsCache.Add(packageServerUrl, dic1);
            }

            Dictionary<CultureInfo, List<PackageDescription>> dic2;
            if (dic1.TryGetValue(installationId, out dic2) == false)
            {
                dic2 = new Dictionary<CultureInfo, List<PackageDescription>>();
                dic1.Add(installationId, dic2);
            }

            if (dic2.ContainsKey(userCulture) == false)
            {
                LoggingService.LogVerbose("PackageServerFacadeCache", "PackageDescription cache miss");
                return null;
            }

            LoggingService.LogVerbose("PackageServerFacadeCache", "PackageDescription returned from cache");
            return dic2[userCulture];
        }



        public void AddCachedPackageDescription(string packageServerUrl, Guid installationId, CultureInfo userCulture, List<PackageDescription> packageDescription)
        {
            LoggingService.LogVerbose("PackageServerFacadeCache", "PackageDescription added to cache");

            Dictionary<Guid, Dictionary<CultureInfo, List<PackageDescription>>> dic1;
            if (_packageDescriptionsCache.TryGetValue(packageServerUrl, out dic1) == false)
            {
                dic1 = new Dictionary<Guid, Dictionary<CultureInfo, List<PackageDescription>>>();
                _packageDescriptionsCache.Add(packageServerUrl, dic1);
            }

            Dictionary<CultureInfo, List<PackageDescription>> dic2;
            if (dic1.TryGetValue(installationId, out dic2) == false)
            {
                dic2 = new Dictionary<CultureInfo, List<PackageDescription>>();
                dic1.Add(installationId, dic2);
            }

            dic2[userCulture] = packageDescription;
            _packageDescriptionsCacheTimestamp = DateTime.Now;
        }



        public void Clear()
        {
            _packageDescriptionsCache = new Dictionary<string, Dictionary<Guid, Dictionary<CultureInfo, List<PackageDescription>>>>();
        }
	}
}
