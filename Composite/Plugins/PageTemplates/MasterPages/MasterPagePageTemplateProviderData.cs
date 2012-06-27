﻿using System;
using System.Configuration;
using Composite.Core.PageTemplates;
using Composite.Core.PageTemplates.Plugins;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration.ObjectBuilder;

namespace Composite.Plugins.PageTemplates.MasterPages
{
    [Assembler(typeof(MasterPagePageTemplateProviderAssembler))]
    internal class MasterPagePageTemplateProviderData : PageTemplateProviderData
    {
        [ConfigurationProperty("directory", IsRequired = false, DefaultValue = "~/App_Data/Razor/PageTemplates")]
        public string Directory
        {
            get { return (string)base["directory"]; }
            set { base["directory"] = value; }
        }
    }

    internal class MasterPagePageTemplateProviderAssembler : IAssembler<IPageTemplateProvider, PageTemplateProviderData>
    {
        public IPageTemplateProvider Assemble(Microsoft.Practices.ObjectBuilder.IBuilderContext context, PageTemplateProviderData objectConfiguration, Microsoft.Practices.EnterpriseLibrary.Common.Configuration.IConfigurationSource configurationSource, ConfigurationReflectionCache reflectionCache)
        {
            var data = objectConfiguration as MasterPagePageTemplateProviderData;
            if (data == null)
            {
                throw new ArgumentException("Expected configuration to be of type " + typeof(MasterPagePageTemplateProviderAssembler).Name,
                                            "objectConfiguration");
            }

            return new MasterPagePageTemplateProvider(data.Name, data.Directory);
        }
    }
}